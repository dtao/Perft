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

        if !logged_in? && request.path !~ %r{^/(?:logout)?$|^/auth/}
          flash[:notice] = "You must log in to continue."
          redirect("/")
        end
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

    get "/logout" do
      session.delete(:user_id)
      flash[:notice] = "You've successfully logged out."
      redirect("/")
    end

    get "/auth/:provider/callback" do |provider|
      user = User.get_or_create(provider, auth_hash["uid"], auth_user_info)
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.name}."
      redirect("/")
    end
  end
end
