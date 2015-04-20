require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test '#signup_success' do
    post :signup, {'username' => 'testuser', 'password' => 'testpass'}
    json = JSON.parse response.body
    assert json['user_name'] == 'testuser'
    assert json['login_count'] == 1
  end

  test '#signup_failure_user' do
    post :signup, {'username' => 'test', 'password' => 'testpass'}
    json = JSON.parse response.body
    assert json['error_code'] == -1
  end

  test '#signup_failure_pwd' do
    post :signup, {'username' => 'testuser', 'password' => 'test'}
    json = JSON.parse response.body
    assert json['error_code'] == -2
  end

  test '#signup_failure_dup' do
    post :signup, {'username' => 'mumumu', 'password' => 'iloveiioopp'}
    json = JSON.parse response.body
    assert json['error_code'] == -3
  end

  test '#login_success' do
    post :login, {'username' => 'mumumu', 'password' => 'iloveiioopp'}
    json = JSON.parse response.body
    assert json['user_name'] == 'mumumu'
    assert json['login_count'] == 2
  end

  test '#login_failure' do
    post :login, {'username' => 'asdfdf', 'password' => 'fdsaasdf'}
    json = JSON.parse response.body
    assert json['error_code'] == -4
  end

  test '#logout' do
    get :logout
    assert_redirected_to root_path
  end

  test '#clearData' do
    post :clear_data
    post :login, {'username' => 'mumumu', 'password' => 'iloveiioopp'}
    json = JSON.parse response.body
    assert json['error_code'] == -4
  end
end
