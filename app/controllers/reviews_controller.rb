class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end
  
  def show
    @review = Review.find(params[:id])
  end
  
  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(review_params)
    @review.user = User.first
    if @review.save
      flash[:success] = "Review was successfully posted"
      redirect_to review_path(@review)
    else
      render 'new'
    end
  end
  
  private
  
  def review_params
    params.require(:review).permit(:name, :movie, :description)
  end
end