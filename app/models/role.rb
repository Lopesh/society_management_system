class Role < ApplicationRecord
  PREDEFINED_ROLES = ["Admin", "Member", "Secretary", "Treasurer", "Chairman", "Admin"].freeze
  
  PREDEFINED_ROLES.each do |role_name|
    define_method "#{role_name.downcase}?" do
      name == role_name
    end
  end

  def self.create_required_roles
    PREDEFINED_ROLES.each do |role_name|
      role = find_or_initialize_by(name: role_name)
      role.save if role.new_record?
    end
  end

  def super_admin?
    name.eql?("super-admin")
  end

  def self.create_role_wise_users(subdomain)
    PREDEFINED_ROLES.each do |role|
      user = User.find_or_initialize_by(email: "#{role}@#{subdomain}.com") 
      user.assign_attributes({name: "#{role} - #{subdomain} - User", password: "#{role}@123", password_confirmation:"#{role}@123", phone: rand(10**9..10**10 - 1), role_id: Role.find_by(name: role).id})   
      user.save
    end
  end
end
