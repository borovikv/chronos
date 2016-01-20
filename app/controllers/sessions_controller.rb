class SessionsController < ApplicationController
  skip_before_action :authorize
  before_action :session_params, only: [:new, :create, :destroy]
  # GET /sessions/new
  def new
    @email = session_params[:email]
    @password = session_params[:password]
  end


  # POST /sessions
  # POST /sessions.json
  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to boards_url
    else
      flash[:alert] = 'Wrong email or password'
      render action: 'new'

    end
  end


  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.permit(:email, :password)
    end
end
