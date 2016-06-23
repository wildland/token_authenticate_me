module TokenAuthenticateMe
  class InvitePolicy < ApplicationPolicy
    def create?
      record.owner_id == current_user.id || super
    end

    def show?
      true
    end

    def update?
      create?
    end

    def destroy?
      record.owner_id == current_user.id || super
    end

    def accept?
      current_user
    end

    def decline?
      current_user
    end

    def permitted_attributes
      [:email, :accepted, :meta]
    end
  end
end
