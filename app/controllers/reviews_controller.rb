class ReviewsController < ApplicationController
  before_action :set_rev, only: [:show, :edit, :update]
  
  def index
    @reviews = Review.all
  end
  
  def show
  end
  
  def new
    @review = Review.new(:movie => params[:movie])
  end
  
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    if @review.save
      flash[:success] = "Review was successfully posted"
      redirect_to review_path(@review)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
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
  
    def set_rev
      @review = Review.find(params[:id])
    end
  
    def review_params
      params.require(:review).permit(:name, :movie, :description)
    end
end