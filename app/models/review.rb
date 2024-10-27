class Review < ApplicationRecord
  belongs_to :user, presence: true
  belongs_to :transaction, presence: true
end
