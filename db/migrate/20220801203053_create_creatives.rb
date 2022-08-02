class CreateCreatives < ActiveRecord::Migration[7.0]
  def change
    create_table :creatives do |t|
      t.string :creative_id, index: { unique: true }, null: false
      t.float :price

      t.timestamps
    end
  end
end
