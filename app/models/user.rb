class User < ApplicationRecord
  has_many :advertisements, dependent: :destroy
  has_many :messages, dependent: :restrict_with_exception
  has_many :negotiations, dependent: :restrict_with_exception
  has_many :reviews, dependent: :destroy

  devise :database_authenticatable,
         :registerable,
         :rememberable,
         :trackable,
         :timeoutable,
         :omniauthable,
         :validatable
  include DeviseTokenAuth::Concerns::User

  REGEX_EMAIL = /\A[^@\s]+@id\.uff\.br\z/
  REGEX_CPF = /(^\d{3}\.\d{3}\.\d{3}-\d{2}$)/

  validates :full_name, presence: true
  validates :password_confirmation, presence: true, on: :create
  validates :email, format: { with: REGEX_EMAIL }, uniqueness: { case_sensitive: false }
  validates :cpf, format: { with: REGEX_CPF }, uniqueness: true
  enum role: %i[comum admin]
end
