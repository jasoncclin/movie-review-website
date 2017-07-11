require 'test_helper'

class ReviewsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(name: "Roger", email: "roger@gmail.com",
                      password: "password", password_confirmation: "password")
    @review = Review.create(name: "The Matrix is okay", movie: "The Matrix",
                            description: "It was an alright movie", user: @user)
    @review2 = @user.reviews.build(name: "Minions", movie: "Minions",
                                  description: "Great")
    @review2.save
  end
  
  test "should get reviews index" do
    get reviews_path
    assert_response :success
  end
  
  test "should get reviews listing" do
    get reviews_path
    assert_template 'reviews/index'
    assert_match @review.name, response.body
    assert_match @review2.name, response.body
  end
end
