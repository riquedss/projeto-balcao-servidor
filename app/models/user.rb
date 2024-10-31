class User < ApplicationRecord
  has_many :advertisements, dependent: :destroy
  has_many :messages, dependent: :restrict_with_exception
  has_many :negotiations, dependent: :restrict_with_exception
  has_many :reviews, dependent: :destroy
end
