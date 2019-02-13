class AddAasmStateToTrades < ActiveRecord::Migration[5.2]
  def change
    add_column :trades, :aasm_state, :string
  end
end
