class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references :follower, null: false
      t.references :followee, null: false

      t.timestamps
    end
    add_foreign_key :follows, :users, column: :follower_id, primary_key: "id", on_delete: :cascade
    add_foreign_key :follows, :users, column: :followee_id, primary_key: "id", on_delete: :cascade
  end
end
