class Bet < ApplicationRecord
    has_many :user_bets, dependent: :destroy
    has_many :users, through: :user_bets
end
