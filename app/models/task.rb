class Task < ApplicationRecord
  include AASM

  # validations
  validates_presence_of :title, :created_by, :state

  aasm column: 'state' do
    state :backlog, initial: true
    state :in_progress
    state :done
    state :cancelled

    event :init do
      transitions from: :backlog, to: :in_progress
    end

    event :finish do
      transitions from: :in_progress, to: :done
    end

    event :cancel do
      transitions from: :in_progress, to: :cancelled
    end
  end

end
