class User < ApplicationRecord
  has_many :advertisements, dependent: :destroy
  has_many :messages, dependent: :nullify
  has_many :negotiations, dependent: :nullify
  has_many :reviews, dependent: :nullify
end
