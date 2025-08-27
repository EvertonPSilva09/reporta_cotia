# == Schema Information
#
# Table name: reports
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  category_id :bigint           not null
#  address_id  :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#  status      :integer
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
