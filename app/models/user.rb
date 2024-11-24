#
# table name: users
# t.string :email, default: "", null: false
# t.string :encrypted_password, default: "", null: false
# t.string :reset_password_token
# t.datetime :reset_password_sent_at
# t.datetime :remember_created_at
# t.timestamps
# t.index [:email], unique: true
# t.index [:reset_password_token], unique: true
# 
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reports, dependent: :destroy
  has_one_attached :image

  enum role: { user: 0, moderator: 1, admin: 2 }

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :user
  end
end
