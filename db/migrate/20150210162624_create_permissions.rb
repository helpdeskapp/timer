class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :user, index: true
      t.string :role

      t.timestamps null: false
    end
    add_foreign_key :permissions, :users
  end
end
