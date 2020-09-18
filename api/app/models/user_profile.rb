class UserProfile < ApplicationRecord
  belongs_to :user
  belongs_to :sex
  belongs_to :place
end
