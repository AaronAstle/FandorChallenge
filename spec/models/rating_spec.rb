require 'rails_helper'

RSpec.describe Rating, type: :model do
  it { should belong_to(:film) }

  it { should validate_presence_of(:rating_value) }
end
