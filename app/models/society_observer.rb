class SocietyObserver < ActiveRecord::Observer
  def after_create(society)
    subdomain = society.subdomain
    Apartment::Tenant.create(subdomain)
    service = TenantSwitchingService.new(society)
    service.within_society do
      Role.create_required_roles
      
      Role.create_role_wise_users(subdomain)
    end
    service.switch_back
  end
end
