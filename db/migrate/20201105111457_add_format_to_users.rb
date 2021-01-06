class AddFormatToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :format, foreign_key: true
  end
end
