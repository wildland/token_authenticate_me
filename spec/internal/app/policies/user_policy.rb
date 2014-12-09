class UserPolicy
  def initialize(*)
  end

  def permitted_attributes
    [:username, :email, :password, :password_confirmation]
  end

  def create?
    true
  end

  def show?
    true
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
