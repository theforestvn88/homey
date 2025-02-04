# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
    def edit_status?
        true
    end

    def update_status?
        true
    end
end
