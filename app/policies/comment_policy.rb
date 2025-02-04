# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
    def create?
        true
    end

    def update?
        true
    end

    def destroy?
        true
    end
end
