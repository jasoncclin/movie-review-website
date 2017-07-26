class CommentsController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.create(params[:comment].permit(:name, :body))
    redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:review_id])
    @comment = @review.comments.find(params[:id])
    @comment.destroy
    redirect_to review_path(@review)
  end
end
