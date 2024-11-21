class CardsController < ApplicationController
  def index
    @cards = Card.all
    @cards = Card.order(created_at: :desc)
      if params[:query].present?
        sql_subquery = "title ILIKE :query OR description ILIKE :query"
        @cards = @cards.where(sql_subquery, query: "%#{params[:query]}%")
      end
  end

  def show
    @card = Card.find(params[:id])
    @reviews = @card.reviews
    @review = Review.new
    @rental = Rental.new
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card.user = current_user
      if @card.save
        redirect_to card_path(@card)
      else
        render :new, status: :unprocessable_entity
      end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to cards_path, status: :see_other
  end

  private

  def card_params
    params.require(:card).permit(:title, :description, :ppd, :photo)
  end
end
