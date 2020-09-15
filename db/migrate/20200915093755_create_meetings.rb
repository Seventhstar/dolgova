class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.string :name
      t.references :format, null: false, foreign_key: true
      t.references :duration, null: false, foreign_key: true

      t.timestamps
    end
  end
end
