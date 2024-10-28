class Negotiation < ApplicationRecord
  belongs_to :user
  belongs_to :advertisement
  has_many :reviews, dependent: :destroy
end
