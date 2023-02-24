class PostPolicy < ApplicationPolicy
  alias_method :post, :record

  def index?
    true
  end

  def new?
    create?
  end

  def create?
    user.present?
  end

  def show?
    user.present?
  end

  def edit?
    update?
  end

  def update?
    user.present?
  end

  def destroy?
    user.present?
  end
end
