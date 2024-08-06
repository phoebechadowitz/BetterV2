class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validate :passwords_must_match

  private

  def passwords_must_match
    if (password != password_confirmation)
      puts password
      puts password_confirmation
      errors.add(:password_confirmation, "doesn't match Password")
    end
  end
end

