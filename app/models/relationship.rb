class Relationship < ApplicationRecord
  # 関連付けで指定するモデル名は単数系
  # defaultは <class名>_idを外部キーとする
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"
end
