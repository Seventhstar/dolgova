class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :event_type, null: false, foreign_key: true
      t.text :comment
      t.date :date
      t.time :time_from
      t.time :time_to
      t.integer :linked_user_id
      t.boolean :online
      t.integer :meeting_id

      t.timestamps
    end
  end
end
