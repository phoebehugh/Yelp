class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :user
  has_many :reviewers, through: :reviews, source: :user

  validates :name, length: {minimum: 3}, uniqueness: true
end
