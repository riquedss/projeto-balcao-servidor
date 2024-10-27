class Message < ApplicationRecord
  belongs_to :user, presence: true
  belongs_to :advertisement, presence: true
end
