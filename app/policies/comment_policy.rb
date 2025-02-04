# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
    def create?
        project_owner? || assigned?
    end

    def update?
        comment_owner?
    end

    def destroy?
        comment_owner?
    end

    private

        def project_owner?
            @record.project.user_id == @user.id
        end

        def assigned?
            Assignment.exists?(user_id: @user.id, project_id: @record.project_id)
        end

        def comment_owner?
            @record.user_id == @user.id
        end
end
