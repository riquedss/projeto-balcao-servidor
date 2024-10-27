class User < ApplicationRecord
  has_many :advertisements, dependent: :destroy
  has_many :messages, dependent: :nullify
  has_many :transactions, dependent: :nullify
  has_many :review, dependent: :nullify
end
