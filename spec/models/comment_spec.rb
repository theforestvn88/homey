require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:project) }
  it { should validate_length_of(:content)
        .is_at_least(10)
        .is_at_most(200)
      }
end
