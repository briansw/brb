class UserPolicy < ApplicationPolicy
  
  def edit?
    user.is_sysop? || user == record || (user.is_admin? && !record.is_sysop?)
  end
  
  def destroy?
    !record.is_sysop? && (user.is_sysop? || (user.is_admin? && user != record))
  end
  
end
