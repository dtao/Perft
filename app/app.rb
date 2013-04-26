module Perft
  class App < Padrino::Application
    register SassInitializer
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    use OmniAuth::Builder do
      provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"]
    end

    configure :development do
      disable :protect_from_csrf
    end

    helpers do
      def logged_in?
        !!session[:user_id]
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
    end

    get "/" do
      @projects = Project.all
      @machines = Machine.all
      render :index
    end

    get "/logout" do
      session.delete(:uid)
      flash[:notice] = "You've successfully logged out."
      redirect("/")
    end

    get "/auth/:provider/callback" do |provider|
      user = User.get_or_create(provider, auth_hash["uid"], auth_user_info)
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.name}!"
      redirect("/")
    end

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 505 do
    #     render 'errors/505'
    #   end
    #
  end
end
