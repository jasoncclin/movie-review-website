require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  
  def setup
    @user = User.create(name: "simon", email: "simon@example.com")
    @review = @user.reviews.build(name: "veg", description: "delicious")
  end
  
  test "movie should be present" do
    @review.movie = " "
    assert_not @review.valid?
  end
  
  test "review without user should be invalid" do
    @review.user_id = nil
    assert_not @review.valid?
  end
  
  test "review should be valid" do
    assert @review.valid?
  end
  
  test "name should be present" do
    @review.name = " "
    assert_not @review.valid?  
  end
  
  test "description should be present" do
    @review.description = " "
    assert_not @review.valid?
  end
  
  test "description shouldn't be less than 5 characters" do
    @review.description = "a" * 3
    assert_not @review.valid?
  end
  
  test "description shouldn't be more than 500 characters" do
    @review.description = "a" * 501
    assert_not @review.valid?
  end

end
