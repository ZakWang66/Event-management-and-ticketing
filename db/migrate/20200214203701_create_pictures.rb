class CreatePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.references :event, null: false, foreign_key: true
      t.string :picture

      t.timestamps
    end
  end
end
