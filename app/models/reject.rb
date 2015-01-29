class Reject < ActiveRecord::Base
  belongs_to :user
  belongs_to :rejected_user, :class_name => "User", foreign_key: :reject_id
end
