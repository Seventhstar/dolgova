class CreateDurations < ActiveRecord::Migration[6.0]
  def change
    create_table :durations do |t|
      t.string :name
      t.integer :minutes

      t.timestamps
    end
  end
end
