# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_many :reports

  validates :name, presence: true, uniqueness: true
end
