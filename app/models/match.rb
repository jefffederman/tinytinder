class Match < ActiveRecord::Base
  belongs_to :user
  belongs_to :liked_user, :class_name => "User", foreign_key: :match_id
end
