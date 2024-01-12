class Rating < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  validates :score, presence: true
end
