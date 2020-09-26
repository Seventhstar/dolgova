class AddTarifToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :tarif, null: true, foreign_key: true
  end
end
