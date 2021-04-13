class CreateBookTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :book_transactions do |t|
      t.belongs_to :user, foreign_key: 'user_id'
      t.belongs_to :book, foreign_key: 'book_id'
      t.datetime :start_date
      t.datetime :end_date
      t.numeric :income, default: 0

      t.timestamps
    end
  end
end
