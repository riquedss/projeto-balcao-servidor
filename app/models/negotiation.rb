class Negotiation < ApplicationRecord
  belongs_to :user
  belongs_to :advertisement
  has_many :messages

  has_many :reviews, dependent: :destroy

  enum :status, %i[ pending confirmed completed cancelled ]

  after_initialize :set_default_status, if: :new_record?

  validates :user, presence: true
  validates :advertisement, presence: true

  validate :user_cannot_negotiate_own_ad, on: :create

  def confirm!
    raise ActiveRecord::RecordInvalid.new(self) unless pending?

    update!(status: :confirmed)
  end

  def complete!
    raise ActiveRecord::RecordInvalid.new(self) unless confirmed?

    update!(status: :completed)
  end

  def can_confirm_negotiation(user_id)
    if pending? && advertisement.user.id != user_id
      errors.add(:base, "Only the advertisement owner can confirm the negotiation.")
    end
  end

  private

  def set_default_status
    self.status ||= :pending
  end

  def user_cannot_negotiate_own_ad
    return if user.nil? || advertisement.nil?

    if advertisement.user == user
      errors.add(:base, "You cannot negotiate with your own advertisement.")
    end
  end
end
