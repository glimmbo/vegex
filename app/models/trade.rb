class Trade < ApplicationRecord
  belongs_to :user

  include AASM
  aasm whiny_transitions: false do
    state :open, initial: true
    state :barter, :pending, :complete, :cancelled, :failed

    event :cancel do # user closes trade completely
      transitions from: [:open, :barter], to: :cancelled 
    end

    event :enter do # offer_user joins trade
      transitions from: :open, to: :barter
    end

    event :leave do # offer_user leaves trade
      transitions from: :barter, to: :open
    end

    event :shake do # both user and offer_user 'accept' quantities
      transitions from: :barter, to: :pending
    end

    event :trade do # once trade has taken place
      transitions from: :pending, to: :complete 
    end

    event :fail do # if either user cancels/leaves trade from pending state
      transitions from: :pending, to: :failed
    end
  end

  def self.available
    where(aasm_state: [:open, :barter])
  end

  def self.closed
    where(aasm_state: [:pending, :cancelled, :complete, :failed])
  end
end
