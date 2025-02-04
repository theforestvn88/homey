# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectPolicy, type: :policies do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:user3) { create(:user) }
    let!(:project) { create(:project, user_id: user1.id) }
    let!(:assignment) { create(:assignment, user_id: user2.id, project_id: project.id) }

    describe 'udapte project status policy' do
        it 'allow project owner to update status' do
            project_policy = ProjectPolicy.new(user1, project)
            expect(project_policy.edit_status?).to be_truthy
            expect(project_policy.update_status?).to be_truthy
        end

        it 'allow assigned user to update status' do
            project_policy = ProjectPolicy.new(user2, project)
            expect(project_policy.edit_status?).to be_truthy
            expect(project_policy.update_status?).to be_truthy
        end

        it 'disallow not assigned user to update status' do
            project_policy = ProjectPolicy.new(user3, project)
            expect(project_policy.edit_status?).to be_falsy
            expect(project_policy.update_status?).to be_falsy
        end
    end
end
