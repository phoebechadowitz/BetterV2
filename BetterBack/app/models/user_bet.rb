class UserBet < ApplicationRecord
  belongs_to :user
  belongs_to :bet
end
