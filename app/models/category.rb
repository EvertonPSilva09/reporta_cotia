#
# table name: categories
# t.string :category
# t.timestamps
# 
class Category < ApplicationRecord
  has_many :reports

  validates :category, presence: true
end
