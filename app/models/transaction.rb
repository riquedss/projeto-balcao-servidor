class Transaction < ApplicationRecord
  belongs_to :user, presence: true
  belongs_to :advertisement, presence: true
  has_many :reviews, dependent: :destroy
end
