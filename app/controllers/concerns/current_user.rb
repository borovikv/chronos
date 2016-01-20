module CurrentUser extend ActiveSupport::Concern
  private

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end