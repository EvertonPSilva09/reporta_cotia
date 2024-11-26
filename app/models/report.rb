#
# table name: reports
# t.string :title
# t.text :description
# t.references :category, null: false, foreign_key: true
# t.references :address, null: false, foreign_key: true
# t.references :user, null: false, foreign_key: true
# t.timestamps
# t.index [:category_id, :address_id, :user_id], unique: true
# t.index [:address_id, :user_id], unique: true
# 
class Report < ApplicationRecord
  belongs_to :category
  belongs_to :address
  belongs_to :user

  validates :title, :description, presence: true
  has_many_attached :images

  enum status: { pending: 0, approved: 1, rejected: 2 }

  scope :pending, -> { where(status: :pending) }

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= :pending
  end

  def translated_status
    I18n.t("report_status.#{status}")
  end

  def self.pending_count
    pending.count
  end
end
