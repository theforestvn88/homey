# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
    def edit_status?
        project_owner? || assigned?
    end

    def update_status?
        project_owner? || assigned?
    end

    private

        def project_owner?
            @record.user_id == @user.id
        end

        def assigned?
            Assignment.exists?(user_id: @user.id, project_id: @record.id)
        end 
end
