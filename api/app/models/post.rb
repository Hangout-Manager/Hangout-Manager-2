class Post < ApplicationRecord
  belongs_to :label
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :participations
  has_many :participated_users, through: :participations, source: :user
end
