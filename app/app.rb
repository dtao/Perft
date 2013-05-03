module Perft
  class App < Padrino::Application
    register SassInitializer
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    # TODO: Read up on whether this is stupid, and if so just how stupid.
    disable :protect_from_csrf

    use OmniAuth::Builder do
      provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"]
    end

    helpers do
      def logged_in?
        !!current_user
      end

      def current_user
        @current_user ||= User.get(session[:user_id])
      end

      def auth_hash
        @auth_hash ||= request.env["omniauth.auth"]
      end

      def auth_user_info
        @auth_user_info ||= auth_hash["info"]
      end

      def authenticate
        auth = Rack::Auth::Basic::Request.new(request.env)
        return auth if auth.provided?

        if !logged_in? && request.path !~ %r{^/(?:login|logout)?$|^/auth/}
          flash[:notice] = "You must log in to continue."
          redirect("/")
        end
      end

      def create_session(provider, uid, user_info)
        user = User.get_or_create(provider, uid, user_info)
        session[:user_id] = user.id
        flash[:notice] = "Welcome, #{user.name}."
        redirect("/")
      end
    end

    before do
      authenticate
    end

    get "/" do
      @projects = current_user.try(:projects) || []
      @machines = current_user.try(:machines) || []
      render :index
    end

    get "/login" do
      if Padrino.env == :development && ENV["DEV_USER_INFO"]
        name, email = ENV["DEV_USER_INFO"].split(/\s+/)
        create_session("github", "123456789", {
          "name" => name,
          "email" => email
        })
      else
        redirect("/auth/github")
      end
    end

    get "/logout" do
      session.delete(:user_id)
      flash[:notice] = "You've successfully logged out."
      redirect("/")
    end

    get "/auth/:provider/callback" do |provider|
      create_session(provider, auth_hash["uid"], auth_user_info)
    end
  end
end
