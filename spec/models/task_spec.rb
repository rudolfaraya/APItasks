require 'rails_helper'

RSpec.describe Task, type: :model do
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
  it { should validate_presence_of(:state) }

end
