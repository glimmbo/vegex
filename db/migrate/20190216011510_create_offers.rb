class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.references :user
      t.references :trade
      t.string :produce
      t.string :aasm_state
      
      t.timestamps
    end
  end
end
