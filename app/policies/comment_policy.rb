class CommentPolicy < ApplicationPolicy
  alias_method :comment, :record

  def create?
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
