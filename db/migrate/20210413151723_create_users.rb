class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.numeric :amount
      t.string :account_number

      t.timestamps
    end
  end
end
