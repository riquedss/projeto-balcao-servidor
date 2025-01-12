class Message < ApplicationRecord
  belongs_to :user
  belongs_to :advertisement

  enum :status, %i[ proposal normal ]

  validates :text, :status, presence: true
  validates :text, length: { minimum: 1, maximum: 250 }
end
