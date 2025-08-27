# == Schema Information
#
# Table name: user_roles
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User::Role < ApplicationRecord
  self.table_name = 'user_roles'

  has_many :users, foreign_key: :role_id

  validates :name, presence: true, uniqueness: true
end
