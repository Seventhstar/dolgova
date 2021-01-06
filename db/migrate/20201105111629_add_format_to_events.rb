class AddFormatToEvents < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :format, foreign_key: true
  end
end
