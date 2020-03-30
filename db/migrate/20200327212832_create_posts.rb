class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :event, null: false, foreign_key: true
      t.text :content
      t.references :parent
      t.references :user, null: false, foreign_key: true
      t.text :title

      t.timestamps
    end
  end
end
