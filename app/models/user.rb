class User < ApplicationRecord
  validates :full_name, :presence => true, :on => :create
  validates :amount, :presence => true, :on => :create
  attr_accessor :borrowed_books

  before_create :assign_account_number

  has_many :book_transactions
  def assign_account_number
    self.account_number = rand(10000000..99999999)
  end
end
