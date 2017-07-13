require 'test_helper'

class ReviewsEditTest < ActionDispatch::IntegrationTest
  
  def setup
  @user = User.create!(name: "Roger", email: "roger@gmail.com", password: "password", password_confirmation: "password")
  @review = Review.create(name: "The Matrix is okay", movie: "The Matrix", description: "It was an alright movie", user: @user)
  end
  
  
  test "reject invalid review update" do
    get edit_review_path(@review)
    assert_template 'reviews/edit'
    patch review_path(@review), params: { review: { name: " ", movie: " ", description: " "}}
    assert_template 'reviews/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "successfully edited a review" do
    get edit_review_path(@review)
    assert_template 'reviews/edit'
    new_name = "new name"
    new_movie = "new movie"
    new_description = "new description"
    patch review_path(@review), params: { review: { name: new_name, movie: new_movie, description: new_description }}
    assert_redirected_to @review
    assert_not flash.empty?
    @review.reload
    assert_match new_name, @review.name
    assert_match new_movie, @review.movie
    assert_match new_description, @review.description
    
  end

end
