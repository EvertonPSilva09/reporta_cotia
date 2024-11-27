#
# table name: categories
# t.string :name
# t.timestamps
# 
class Category < ApplicationRecord
  has_many :reports

  validates :name, presence: true
end
