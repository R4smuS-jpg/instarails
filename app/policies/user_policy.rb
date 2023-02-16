class UserPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def new?
    create?
  end

  def create?
    !user.present?
  end

  def show?
    user.present?
  end

  def edit?
    update? 
  end

  def update?
    user == record
  end

  def destroy?
    update?
  end
end
