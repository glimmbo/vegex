class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :trade

  include AASM
  aasm whiny_transitions: false do
    state :pending, initial: true
    state :accepted, :rejected, :cancelled

    event :accept do
      transitions from: :pending, to: :accepted 
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end

    event :cancel do
      transitions from: :pending, to: :cancelled
    end

  end
  
end
