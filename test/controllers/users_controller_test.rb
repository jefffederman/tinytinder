require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create, user: { login: 'uniquelogin', gender: 'male', age: 25, age_interest: '23 - 27', gender_interest: 'female' }
    assert_response 302
  end

end
