class RentalsController < ApplicationController
  # existing rentals will show on dashboard (= dashboards controller)
  # new rentals will be actionned by the card shows (= cards controller)
  before_action :set_card, only: :create

  def create
    @rental = Rental.new(rental_params)
    @rental.card = @card
    if @rental.save
      redirect_to card_path(@card)
    else
      @reviews = @card.reviews
      @review = Review.new
      render "cards/show", status: :unprocessable_entity
    end
  end

  private

  def set_card
    @card = Card.find(params[:card_id])
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date)
  end
end

# def create
#   @rental = Rental.new(params[:card_id])
#   @rental.user = current_user
#   if @rental.save
#     redirect_to card_path(@rental)
#   else
#     render :new, status: :unprocessable_entity
#   end
# end

# private

# def rental_params
#   params.require(:rental).permit(:start_date, :end_date)
# end