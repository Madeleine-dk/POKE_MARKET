class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = Card.all
    @cards = Card.order(created_at: :desc)
    if params[:query].present?
      sql_subquery = "title ILIKE :query OR description ILIKE :query"
      @cards = @cards.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
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
    if @card.user == current_user
      @card.destroy
      redirect_to cards_path, notice: 'Card was successfully destroyed.'
    else
      redirect_to cards_path, alert: 'You are not authorized to delete this card.'
    end
  end

  def edit
    # No need to set @card, already done by the set_card callback
  end

  def update
    if @card.update(card_params)
      redirect_to @card, notice: 'Card was successfully updated.'
    else
      render :edit
    end
  end

  private

  def card_params
    params.require(:card).permit(:title, :description, :ppd, :photo)
  end

  def set_card
    @card = Card.find(params[:id])
  end
end
