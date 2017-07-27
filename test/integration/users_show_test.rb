require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(name: "Roger", email: "roger@gmail.com", password: "password", password_confirmation: "password")
    @review = Review.create(name: "The Matrix is okay", movie: "The Matrix", description: "It was an alright movie", user: @user)
    @review2 = @user.reviews.build(name: "Minions", movie: "Minions", description: "Great")
    @review2.save
  end
  
  test "get users show" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select "a[href=?]", review_path(@review), text: @review.name
    assert_select "a[href=?]", review_path(@review2), text: @review2.name
    assert_match @review.description, response.body
    assert_match @review2.description, response.body
    assert_match @user.name, response.body
  end
end
