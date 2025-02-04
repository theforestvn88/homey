# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentPolicy, type: :policies do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:user3) { create(:user) }
    let!(:project) { create(:project, user_id: user1.id) }
    let!(:assignment) { create(:assignment, user_id: user2.id, project_id: project.id) }
    let!(:comment) { Comment.new(user_id: user1.id, project_id: project.id) }

    describe 'create comment policy' do
        it 'allow project owner to create comment' do
            comment_policy = CommentPolicy.new(user1, comment)
            expect(comment_policy.create?).to be_truthy
        end

        it 'allow assigned user to create comment' do
            comment_policy = CommentPolicy.new(user2, comment)
            expect(comment_policy.create?).to be_truthy
        end

        # it 'disallow not assigned user to create comment' do
        #     comment_policy = CommentPolicy.new(user3, comment)
        #     expect(comment_policy.create?).to be_falsy
        # end
    end
end
