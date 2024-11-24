#
# table name: addresses
# t.string :cep
# t.string :street
# t.string :neighbhood
# t.string :city
# t.string :number
# t.timestamps
# 
class Address < ApplicationRecord

  validates :cep, :street, :neighbhood, :city, :number, presence: true
end
