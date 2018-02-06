require 'rails_helper'

RSpec.describe Rating, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it { should belong_to(:film) }

  it { should validate_presence_of(:rating) }
end
