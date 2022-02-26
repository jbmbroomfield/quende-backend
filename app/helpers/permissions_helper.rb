module PermissionsHelper
  
  def update_permissions(**new_permissions)
    update(permissions: (permissions || {}).merge(new_permissions))
  end

  def has_permission?(permission_type, authority)
    return false if !permissions[permission_type]
    if authority.respond_to?(:authority)
      authority = authority.authority
    end
    authority >= permissions[permission_type]
  end
  
  [:view, :url_view, :post, :password_post, :create_topic, :create_subsection, :create_section].each do |permission_type|
    method_sym = :"can_#{permission_type}?"
    define_method method_sym do |authority|
      has_permission?(permission_type.to_s, authority)
    end
  end

end