class UsersController < ApplicationController
  before_action :authenticate_user!
 
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
    else
      redirect_to user_path(current_user)
    end 

    
  end
  
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "successfully."
      redirect_to user_path(user.id)
    else
      @user = user
      flash[:not] = "error."
      render :edit
  
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image_id)
  end
  
end
