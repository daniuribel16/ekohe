class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.numeric :stock
      t.numeric :loans, default: 0

      t.timestamps
    end
  end
end
