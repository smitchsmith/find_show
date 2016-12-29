class CreateEvent < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.datetime :date
      t.integer  :venue_id
      t.string   :price

      t.timestamps
    end
  end
end
