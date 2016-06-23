module TokenAuthenticateMe
  class InvitePolicy < ApplicationPolicy
    def create?
      false
    end

    def show?
      true
    end

    def update?
      record.id == current_user.id || super
    end

    def destroy?
      record.id == current_user.id || super
    end

    def permitted_attributes
      [:username, :email, :password, :password_confirmation]
    end
  end
end
