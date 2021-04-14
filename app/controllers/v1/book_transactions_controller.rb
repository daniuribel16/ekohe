module V1
  class BookTransactionsController < ApplicationController

    def create
      b_trans = BookTransaction.where(user_id: params[:user_id], book_id: params[:book_id], end_date: nil).first
      return render json: { error: "User already has one of these" }, status: :unauthorized unless b_trans.nil?

      # check if user exist
      user = User.find(params[:user_id])
      return render json: { error: "There is not enough balance" }, status: :unauthorized if user.amount <= 0

      # check if there are books available
      book = Book.find(params[:book_id])

      # borrow a book 
      trans = BookTransaction.new {|bt|
        bt.book_id = params[:book_id]
        bt.user_id = params[:user_id]
      }
      if trans.save
        # calculate new stock after loan
        book.stock -= 1
        book.loans += 1
        book.save
        render json: { data: trans.id }, status: :created
      else
        render json: { error: "Invalid Params" }, status: :unprocessable_entity
      end
    end

    def update
      # find and check transaction
      trans = BookTransaction.where(user_id: params[:user_id], book_id: params[:book_id], end_date: nil).first
      return render json: { error: "Invalid Params" }, status: :not_found if trans.nil?
      return render json: { error: "Book already returned"}, status: :bad_request if trans.end_date

      # get user to update account amount
      user = User.find(params[:user_id])
      book = Book.find(params[:book_id])
      
      # returning book assigning a end date
      trans.end_date = DateTime.now
      # calculating final fee according to days and fee
      fee_to_charge = (((trans.end_date - trans.start_date) / 86400).ceil * ENV['FEE_PER_DAY'].to_i).to_i
      final_fee = user.amount >= fee_to_charge ? fee_to_charge : user.amount
      trans.income = final_fee
      trans.save
      # rearraging stock
      book.loans -= 1
      book.stock += 1
      book.save
      # substracting fee from user account amount
      user.amount = user.amount >= fee_to_charge ? user.amount - fee_to_charge : 0
      user.save

      render json: { data: user.id }, status: :ok
    end

  end
end