class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.references :event, null: false, foreign_key: true
      t.string :video

      t.timestamps
    end
  end
end
