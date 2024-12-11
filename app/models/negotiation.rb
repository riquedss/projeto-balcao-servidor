class Negotiation < ApplicationRecord
  belongs_to :user
  belongs_to :advertisement
  has_many :reviews, dependent: :destroy

  enum :status, %i[ pending confirmed completed cancelled ]

  after_initialize :set_default_status, if: :new_record?

  validate :owner_confirmation, on: :update, if: :pending?
  validate :can_confirm_negotiation, on: :update, if: :pending?
  validate :user_cannot_negociate_own_ad, on: :create

  def confirm!
    if pending?
      update!(status: :confirmed)
    else
      errors.add(:base, "The negotiation cannot be confirmed.")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def complete!
    if confirmed?
      update!(status: :completed)
    else
      errors.add(:base, "The negotiation must be confirmed before it can be completed.")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  private

  def set_default_status
    self.status ||= :pending
  end

  def owner_confirmation
    if advertisement.user != user
      errors.add(:base, "Only the advertisement owner can confirm the negotiation.")
    end
  end

  def can_confirm_negotiation
    if advertisement.user != user
      errors.add(:base, "Only the advertisement owner can confirm the negotiation.")
    end
  end

  def user_cannot_negociate_own_ad
    if advertisement.user == user
      errors.add(:base, "You cannot negotiate with your own advertisement.")
    end
  end
end