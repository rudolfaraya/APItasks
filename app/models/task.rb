class Task < ApplicationRecord
  # validations
  validates_presence_of :title, :created_by, :state
end
