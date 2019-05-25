class BooksController < ApplicationController
before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @books = Book.all.reverse_order
    @book = Book.new
    @user = current_user
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all.reverse_order
    if @book.save
      flash[:notice] = "Your post was successfully saved!"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "Caution! error has found!"
      render :index
    end
  end

  def show
    @findbook = Book.find(params[:id])
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "Your post was successfully Updated!"
    redirect_to book_path(@book.id)
    else
    flash[:notice] = "Caution! error has found!"
    render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
    flash[:notice] = "Your post was successfully deleted"
    redirect_to books_path
    else
    flash[:notice] = "Caution! error has found!"
    render :show
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introdu)
  end
  
    def correct_user
    user = Book.find(params[:id]).user
    if current_user != user
      flash[:notice] = "You cannot acceess this page :("
      redirect_to books_path
    end
    end
end