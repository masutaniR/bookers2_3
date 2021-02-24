class UsersController < ApplicationController
  def index
    @users = User.where(is_valid: true)
    @user = current_user
    @new_book = Book.new

  end

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to current_user
    end
  end

  def update
    @user = User.find(params[:id])
    if  @user.name == "guest"
      redirect_to edit_user_path(@user), alert: 'ゲストユーザーは編集できません'
    elsif @user.update(user_params)
      redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  def hide_confirm
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to current_user
    end
  end

  def hide
    @user = User.find(params[:id])
    if @user.valid_password?(params[:user][:password])
      @user.update(is_valid: false)
      reset_session
      redirect_to root_path, notice: 'ありがとうございました。またのご利用を心よりお待ちしております。'
    else
      redirect_to edit_user_path(@user), alert: 'パスワードが違います'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
