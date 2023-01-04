class AccountsController < ApplicationController
  include SessionHelper
  before_action :correct_user

  def edit
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    if image_update?(params[:user][:avatar])
      if @user.update(avatar_params)
        other_attr = account_params
        @user.name = other_attr[:name]
        @user.status_message = other_attr[:status_message]
        @user.introduction = other_attr[:introduction]
        render 'edit'
      else
        render 'edit'
      end
    else
      if @user.update(account_params)
        redirect_to @user
      else
        render 'edit'
      end
    end
  end

  private
    # プロフィール画像を更新する場合、trueを返す
    def image_update?(avatar)
      return true unless avatar.nil?
    end

    def account_params
      attributes = [:name, :status_message, :introduction]
      params.require(:user).permit(attributes)
    end

    def avatar_params
      attributes = [:image_x, :image_y, :image_w, :image_h, :avatar]
      params.require(:user).permit(attributes)
    end

    # 正しいユーザーか確認
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to root_url unless current_user?(@user)
    end
end
