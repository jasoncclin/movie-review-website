require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "should get signup path" do
    get signup_path
    assert_response :success
  end
  
  test "reject invalid signup" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: {user: {name: "", email: "", password: "pass",
                                password_confirmation: ""}}
    end
  end
  
  test "accept valid signup" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: {user: {name: "simon", email: "simon@sz.com", password: "simon",
                                password_confirmation: "simon"}}
    end
    follow_redirect!
    assert_not flash.empty?
  end
end
