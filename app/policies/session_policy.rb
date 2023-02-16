class SessionPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    !user.present?
  end

  def destroy?
    user.present?
  end
end
