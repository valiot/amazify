class PodcastPolicy < ApplicationPolicy
  def approve?
    user.admin?
  end

  def reject?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
