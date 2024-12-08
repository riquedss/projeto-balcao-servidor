class Negotiation < ApplicationRecord
  belongs_to :user
  belongs_to :advertisement
  has_many :reviews, dependent: :destroy

  enum :status, %i[ pending in_progress confirmed cancelled ]

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :pending
  end
end
