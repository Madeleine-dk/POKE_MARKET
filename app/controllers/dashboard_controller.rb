class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @rented_cards = current_user.rentals.includes(:card).map(&:card)
    @uploaded_cards = current_user.cards
  end
end
