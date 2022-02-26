module PermissionsHelper

  def permissions
    Permission.filter_by(class_name: self.class.name, object_id: self.id)
  end

  def get_permission(permission_type)
    permissions.find_or_create_by(permission_type: permission_type)
  end

  def set_permission(permission_type, authority)
    permission = get_permission(permission_type)
    permission.update(authority: authority)
  end

  def has_permission?(permission_type, authority)
    authority >= get_permission(permission_type).authority
  end

end