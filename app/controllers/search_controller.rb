class SearchController < ApplicationController
  # def index
  #   redirect_to root_url
  # end

  def index
    param = search_params
    unless param.blank? 
      @user = User.find_by(user_name: param[:user_name])
      if @user
        redirect_to user_path(@user)
      else
        flash.now[:alert] = "ユーザーが見つかりません"
        render 'index'
      end
    else
    end
  end

  private
  def search_params
    params.permit(:user_name)
  end
end
