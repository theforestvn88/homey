# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should belong_to(:owner) }
  it { should have_many(:assignments).dependent(:destroy) }
  it { should have_many(:members) }
  it { should have_many(:comments).dependent(:destroy) }
end
