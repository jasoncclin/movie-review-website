class Review < ApplicationRecord
  validates :name, presence: true
  validates :movie, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500}
  belongs_to :user
  validates :user_id, presence: true
  has_many :comments, dependent: :destroy
end
