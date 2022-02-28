module PermissionsHelper
  
  def update_permissions(**new_permissions)
    update(permissions: (permissions || {}).merge(new_permissions))
  end
  
  [:view, :url_view, :post, :password_post, :create_topic, :create_subsection, :create_section].each do |permission_type|
    method_sym = :"can_#{permission_type}?"
    define_method method_sym do |authority|
      has_permission?(permission_type.to_s, authority)
    end
  end

  private

  def has_permission?(permission_type, authority)
    return false if !permissions[permission_type]
    authority = authority.authority if authority.respond_to?(:authority)
    authority >= permissions[permission_type]
  end

end