# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should belong_to(:owner) }
  it { should have_many(:assignments).dependent(:destroy) }
  it { should have_many(:members) }
  it { should have_many(:comments).order(updated_at: :desc).dependent(:destroy) }
  it { 
      should define_enum_for(:status).
        with_values(
          pending: 'Pending',
          active: 'Active',
          archived: 'Archived'
        ).
        backed_by_column_of_type(:enum)
    }
end
