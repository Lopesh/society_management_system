class TenantSwitchingService
  attr_accessor :society, :current_tenant, :new_tenant

  def initialize(society_id)
    @society = Society.find_by(id: society_id)
    @current_tenant = Apartment::Tenant.current
  end

  def switch_to_new
    Apartment::Tenant.switch!(society.subdomain)
  end

  def switch_back
    Apartment::Tenant.switch!(current_tenant)
  end

  def within_society
    Apartment::Tenant.switch(society.subdomain)  do
      yield
    end
  end
end