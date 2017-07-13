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
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:success] = "Review was updated!"
      redirect_to review_path(@review)
    else
      render 'edit'
    end
  end
  
  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "Review Terminated"
    redirect_to reviews_path
  end
  
  private
  
  def review_params
    params.require(:review).permit(:name, :movie, :description)
  end
end