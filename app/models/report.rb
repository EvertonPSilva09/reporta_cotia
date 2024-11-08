class Report < ApplicationRecord
  belongs_to :category
  belongs_to :address
  belongs_to :user

  validates :title, :description, presence: true
end
