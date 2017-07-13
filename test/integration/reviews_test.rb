require 'test_helper'

class ReviewsTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(name: "Roger", email: "roger@gmail.com", password: "password", password_confirmation: "password")
    @review = Review.create(name: "The Matrix is okay", movie: "The Matrix", description: "It was an alright movie", user: @user)
    @review2 = @user.reviews.build(name: "Minions", movie: "Minions", description: "Great")
    @review2.save
  end
  
  test "should get reviews index" do
    get reviews_path
    assert_response :success
  end
  
  test "should get reviews listing" do
    get reviews_path
    assert_template 'reviews/index'
    assert_select "a[href=?]", review_path(@review), text: @review.name
    assert_select "a[href=?]", review_path(@review2), text: @review2.name
  end
  
  test "should get recipes show" do
    get review_path(@review)
    assert_template 'reviews/show'
    assert_match @review.name, response.body
    assert_match @review.description, response.body
    assert_match @user.name, response.body
  end
  
  test "create new valid review" do
    get new_review_path
    assert_template 'reviews/new'
    name_of_review = "Best movie evar"
    name_of_movie = "Minions"
    description_of_review = "It was for kids!!!!"
    assert_difference "Review.count", 1 do
      post reviews_path, params: { review: { name: name_of_review, movie: name_of_movie, description: description_of_review}}
    end
    follow_redirect!
    assert_match name_of_movie, response.body
    assert_match name_of_review.capitalize, response.body
    assert_match description_of_review, response.body
  end
  
  test "reject invalid review" do
    get new_review_path
    assert_template 'reviews/new'
    assert_no_difference "Review.count" do
      post reviews_path, params:{ review: {name: "", description: "", movie: ""}}
    end
    assert_template 'reviews/new'
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end
