class Task < ApplicationRecord
  include AASM

  # validations
  validates_presence_of :title, :created_by, :state, :end_date
  validates :title, uniqueness: true
  validate :end_date_cannot_be_in_the_past

  def end_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end

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
