class ReviewsController < ApplicationController
before_action :ensure_logged_in
before_action :load_review, only: [ :edit, :update, :destroy]
before_action :ensure_user_owns_review, only: [:edit, :update, :destroy]

  def load_review
    @review = Review.find(params[:id])
  end

  def ensure_user_owns_review
    unless current_user == @review.user
      flash[:alert] = "You are not the owner of this review"
      redirect_to new_sessions_url
    end
  end

  def edit

    @product = @review.product
  end

  def create
    @review = Review.new
    @product = @review.product
    @review.comment = params[:review][:comment]
    @review.product_id = params[:product_id]
    @review.user = current_user
    if @review.save
      flash[:notice] = "review is successfully created!"
      redirect_to "/products/#{params[:product_id]}"
    else
      render :edit

    end
  end

  def update

    @product = @review.product
    @review.comment = params[:review][:comment]
    @review.product_id = params[:product_id]
    @review.user = current_user
    if @review.save
      flash[:notice] = "review is successfully created!"
      redirect_to "/products/#{params[:product_id]}"
    else
      render :edit

    end
  end

  def destroy

    @review.destroy
    flash[:notice] = "review deleted!"
    redirect_to "/products/#{params[:product_id]}"

  end



end
