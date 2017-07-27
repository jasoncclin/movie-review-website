require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Roger", email: "roger@gmail.com", password: "password", password_confirmation: "password")
  end
  
  test "reject invalid edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {name: "", email: "test@test.com"}}
    assert_template 'users/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid signup" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {name: "AshKethcup", email: "test@test.com"}}
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "AshKethcup", @user.name
    assert_match "test@test.com", @user.email
  end
  
  
end
