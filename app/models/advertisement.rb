class Advertisement < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :restrict_with_exception
  has_many :messages, dependent: :destroy
end