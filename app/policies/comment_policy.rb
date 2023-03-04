class CommentPolicy < ApplicationPolicy
  alias_method :comment, :record

  def create?
    user.present?
  end

  def edit?
    update?
  end

  def update?
    comment.user == user
  end

  def destroy?
    comment.user == user
  end
end
