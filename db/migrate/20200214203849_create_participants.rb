class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :role, null: false, default: 0

      t.timestamps
    end
  end
end
