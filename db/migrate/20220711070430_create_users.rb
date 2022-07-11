class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :email
      t.text :first_name
      t.text :last_name
      t.text :role
      t.text :password

      t.timestamps
    end
  end
end
