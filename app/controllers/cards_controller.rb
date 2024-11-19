class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card.save
    redirect_to card_path
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to cards_path, status: :see_other
  end

  private

  def card_params
    params.require(:card).permit(:title, :description, :ppd)
  end
end
