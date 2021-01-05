require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my dirty little secret"

  end

  get '/' do
    erb :homepage
  end

  get '/signup' do
    # binding.pry
    if logged_in?
      redirect '/tweets'
    end
    erb :signup
  end

  post '/signup' do
  #  binding.pry
  if params[:username] != "" && params[:email] != "" && params[:password] != ""
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    
    session.clear
    redirect "/login"
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @user = User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect '/login'
      end
    end
  end

end
