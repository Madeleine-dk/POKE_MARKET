class AddCardIdToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :card_id, :integer
  end
end
