class CreateInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :infos do |t|
      t.string :block_name
      t.text :content

      t.timestamps
    end
  end
end
