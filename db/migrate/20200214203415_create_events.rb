class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.decimal :price, precision: 6, scale: 2
      t.date :time
      t.string :place
      t.text :description

      t.timestamps
    end
  end
end
