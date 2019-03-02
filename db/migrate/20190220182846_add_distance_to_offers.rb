class AddDistanceToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :distance, :float
  end
end
