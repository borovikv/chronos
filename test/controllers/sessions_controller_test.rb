require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:sam)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select '#email', 1
  end

  test "should create session" do
    post :create,  email: @user.email, password: 'secret'
    assert_equal @user.id, session[:user_id]
    assert_redirected_to @user

  end

  test "should fail create session" do
    post :create,  email: @user.email, password: 'password'
    assert_not_equal @user.id, session[:user_id]
    assert_select '#email', 1
    assert_select '#email' do
      assert_select "[value=?]", @user.email
    end
  end


  test "should destroy session" do
    delete :destroy
    assert_redirected_to login_url
  end
end
