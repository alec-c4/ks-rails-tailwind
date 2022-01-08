class Users::ProfilePolicy < ApplicationPolicy
  def edit?
    true
  end

  def update?
    edit?
  end
end
