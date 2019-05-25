class UsersController < ApplicationController
before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all.reverse_order
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
      flash[:notice] = "Your profile was successfully Updated!"
      redirect_to user_path(@user.id)
      else
      flash[:notice] = "Caution! error has found! Check the following direction."
      render :edit
      end
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :introduction)
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      flash[:notice] = "You cannot acceess this page :("
      redirect_to user_path(current_user)
    end
  end
end