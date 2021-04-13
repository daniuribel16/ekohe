class BookTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  before_create :assign_start_date

  def assign_start_date
    self.start_date = DateTime.now
  end
end
