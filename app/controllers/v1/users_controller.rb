module V1
  class UsersController < ApplicationController

    def show
      user = User.find(params[:id])
      user.borrowed_books = user.book_transactions.reject{|bt| bt.end_date}.map{|bt| bt.book}

      render json: { data: user.as_json(
        only: [:id, :full_name, :account_number, :amount],
        include: { borrowed_books: {
          only: [:id, :title, :author]
        }}
      )}, status: :ok
    end

    def create
      user = User.create(create_user_params)
      if user.valid?
        render json: { data: user.id }, status: :created
      else
        render json: { error: "Invalid Params" }, status: :unprocessable_entity
      end
    end

    def update
      return render status: :bad_request if params[:amount].nil? || params[:amount] < 0

      user = User.find_by_id(params[:id])
      return render json: { error: "Id invalido" }, status: :not_found if user.nil?
      
      user.amount = params[:amount]
      user.save
      render json: { data: user.id }, status: :ok
    end

    private
      def create_user_params
        params.require(:user).permit(:full_name, :amount)
      end
  end
end