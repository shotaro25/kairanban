class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
         flash[:success] = '更新しました'
         redirect_to  user_path(@user.id)
      else
        render 'edit'
      end
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: true)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :name_kana, :postal_code, :address, :email, :telephone_number, :is_active)
  end

end