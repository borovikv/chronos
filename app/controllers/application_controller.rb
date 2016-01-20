class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include CurrentUser

  protect_from_forgery with: :exception
  before_action :authorize
  before_action :set_current_user
  before_action :have_permission

  protected
    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: 'Log in!'
      end
    end

    def have_permission
      object = nil
      if params[:controller] == 'boards'
        object = Board.find_by(id: params[:id])


      elsif params[:controller] == 'cards'
        object = Card.find_by(id: params[:id])

      elsif params[:controller] == 'groups'
        object = Group.find_by(id: params[:id])

      elsif params[:controller] == 'users'
        user = User.find_by(id: params[:id])

        if user != @current_user
          redirect_to user_url @current_user
        end
      end

      unless object.nil? || object.user_have_permission_to_view(@current_user)
        redirect_to root_path
      end
    end
end
