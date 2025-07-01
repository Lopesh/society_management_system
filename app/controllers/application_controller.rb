class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :switch_tenant
  before_action :set_current_society
  before_action :authenticate_user!, unless: -> { devise_controller? }

  def switch_tenant
    subdomain = request.subdomain
    puts "#{subdomain}"
    subdomain = 'public' if ["www", "admin"].include?(subdomain)
    Apartment::Tenant.switch!(subdomain)
  end

  def current_society
    @current_society
  end

  private

  def set_current_society
    subdomain = request.subdomain
    return if subdomain.blank? || ["www", "admin"].include?(subdomain)

    @current_society = Society.find_by(subdomain: subdomain)
    if @current_society.nil?
      redirect_to root_url(subdomain: nil), alert: "Society not found"
    end
  end

  helper_method :current_society
end
