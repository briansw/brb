class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :username
      t.string  :email
      t.string  :password_digest
      t.boolean :is_admin, default: false
      t.boolean :is_sysop, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
