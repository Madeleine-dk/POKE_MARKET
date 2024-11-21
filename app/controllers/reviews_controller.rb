class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @card = Card.find(params[:card_id])
    @review.card = @card
    if @review.save
      redirect_to card_path(@review.card), notice: 'Review was successfully created.'
    else
      @reviews = @card.reviews
      render "cards/show", status: :unprocessable_entity, alert: 'Review was not created.'
    end
  end

  def review_params
    params.require(:review).permit(:name, :rating, :comment)
  end
end
