module UsersHelper
  # 渡されたユーザーがフォローしているユーザーであればtrueを返す
  def is_followed?(user)
    current_user.following.include?(user)
  end
  
  #.渡されたユーザーと相互フォローであればtrueを返す
  def mutual_followed?(user)
    current_user.following.include?(user) && current_user.followers.include?(user)
  end
end
