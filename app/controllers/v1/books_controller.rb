module V1
  class BooksController < ApplicationController

    def book_income
      start_date = params[:start_date] || DateTime.new(2000,1,1,0,0,0)
      end_date = params[:end_date] || DateTime.new(3000,1,1,0,0,0)
      trans = BookTransaction.where("book_id = ? AND start_date >= ? AND end_date <= ?", params[:id], start_date, end_date)
      income = trans.reduce(0) {|sum, bt| sum + bt.income}
      render json: { data: income }
    end

    def show
      book = Book.find(params[:id])
      book.user_loans = book.book_transactions.reject{|bt| bt.end_date}.map{|bt| bt.user}

      render json: { data: book.as_json(
        only: [:id, :title, :stock, :loans, :income],
        include: { user_loans: {
          only: [:id, :full_name, :account_number]
        }}
      )}, status: :ok
    end

    def create
      book = Book.create(books_params)
      if book.valid?
        render json: { data: book.id }, status: :created
      else
        render json: { error: "Invalid Params" }, status: :unprocessable_entity
      end
    end

    private
      def books_params
        params.require(:book).permit(:title, :author, :stock)
      end
  end
end