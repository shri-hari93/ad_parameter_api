class CreatePlacements < ActiveRecord::Migration[7.0]
  def change
    create_table :placements do |t|
      t.string :placement_id, index: { unique: true }, null: false
      t.float :floor_price

      t.timestamps
    end


  end
end
