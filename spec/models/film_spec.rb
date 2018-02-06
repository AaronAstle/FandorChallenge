require 'rails_helper'

RSpec.describe Film, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it { should have_many(:ratings).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:created_by) }

end
