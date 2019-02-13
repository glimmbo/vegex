class User < ApplicationRecord
  has_secure_password
  has_many :trades
  include AASM

  aasm whiny_transitions: false do
    state :active, initial: true
    state :on_hold, :removed

    event :remove do
      transitions from: [:active, :on_hold], to: :removed
    end

    event :hold do
      transitions from: :active, to: :on_hold
    end
  end

  validates :email, presence: true,
  uniqueness: true,
  format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


end
