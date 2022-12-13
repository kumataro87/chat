class AccountsController < ApplicationController
  include SessionHelper
  before_action :correct_user

  def edit
    @user = User.find_by(params[:user_id])
  end

  def update
    @user = User.find_by(params[:user_id])
    if @user.update(account_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def account_params
      params.require(:user).permit(:name, :status_message, :introduction, :avatar)
    end

    # 正しいユーザーか確認
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to root_url unless current_user?(@user)
    end
end
