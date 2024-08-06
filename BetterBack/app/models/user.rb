class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validate :passwords_must_match
  has_many :user_bets, dependent: :destroy
  has_many :bets, through: :user_bets

  private

  def passwords_must_match
    if (password != password_confirmation)
      errors.add(:password_confirmation, "doesn't match Password")
    end
  end
end

