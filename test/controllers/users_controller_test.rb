require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:sam)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: 'new_user@mail.com', password: 'secret', password_confirmation: 'secret' }
    end

    assert_redirected_to users_path
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { email: @user.email, password: 'secret', password_confirmation: 'secret' }
    assert_redirected_to users_path
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  test "shouldn't create user" do
    assert_no_difference('User.count') do
      post :create, user: { email: @user.email, password: 'secret', password_confirmation: 'secret' }
    end
    assert_response :success
    assert_select '#error_explanation'
    assert_select 'form div.has-error input#user_email'
  end
end
