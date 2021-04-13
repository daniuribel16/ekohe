class Book < ApplicationRecord
  validates :title, :presence => true, :on => :create
  validates :author, :presence => true, :on => :create
  validates :stock, :presence => true, :on => :create

  has_many :book_transactions
  attr_accessor :user_loans

end
