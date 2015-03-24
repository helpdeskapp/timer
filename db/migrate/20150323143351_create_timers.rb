class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.text :title
      t.string :kind
      t.integer :amount,   :default => 0
      t.boolean :active,   :default => true
      t.datetime :start_at
      t.datetime :end_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
