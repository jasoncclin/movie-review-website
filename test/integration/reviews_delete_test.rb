require 'test_helper'

class ReviewsDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Roger", email: "roger@gmail.com", password: "password", password_confirmation: "password")
    @review = Review.create(name: "The Matrix is okay", movie: "The Matrix", description: "It was an alright movie", user: @user)
  end
  
  test "deleted review" do
    get review_path(@review)
    assert_template 'reviews/show'
    assert_select 'a[href=?]', review_path(@review), text: "Delete"
    assert_difference "Review.count", -1 do
      delete review_path(@review)
    end
    assert_redirected_to reviews_path
    assert_not flash.empty?
  end
end
