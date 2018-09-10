module RolesConcern
  extend ActiveSupport::Concern
  def is_normal_user?
    self.role >= 1
  end
  def is_admin_user?
    self.role >= 2
  end
end