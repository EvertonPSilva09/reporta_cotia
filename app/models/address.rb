# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  cep        :string
#  street     :string
#  neighbhood :string
#  city       :string
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Address < ApplicationRecord

  validates :cep, :street, :neighbhood, :city, :number, presence: true
end
