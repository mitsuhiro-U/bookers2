class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @book = Book.new
  end
  
  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash[:notice] = "successfully."
      redirect_to book_path(book)
    else
      flash[:not] = "error."
      @book = book
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  
  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
    #@book = Book.find(params[:id])
    #@user = @book.user
  end
  
  def show
    @book2 = Book.find(params[:id])
    @user = @book2.user
    @book = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user.id == current_user.id
    else
      redirect_to books_path
    end 
    
  end
  
  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "successfully."
      redirect_to book_path(book)
    else
    @book = book
    flash[:not] = "error."
    render :edit

      
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
    
  end  
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
