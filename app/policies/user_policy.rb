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
    true
  end

  def edit?
    update? 
  end

  def update?
    user.present?
  end

  def delete_avatar?
    user.present?
  end

  def destroy?
    user.present?
  end
end
