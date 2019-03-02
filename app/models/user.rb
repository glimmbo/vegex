class User < ApplicationRecord
  has_secure_password
  has_many :trades
  has_many :offers
  
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  include AASM
  aasm whiny_transitions: false do
    state :active, initial: true
    state :removed

    event :remove do
      transitions from: :active, to: :removed
    end
  end

  validates(
    :email,
    presence: true,
    uniqueness: true,
    format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  )

  validates(
    :name,
    presence: true,
    uniqueness: true
  )

  def slot_available
    trades.where(aasm_state: [:open, :barter, :pending]).count < slots ? true : false
  end

end
