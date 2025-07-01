class SocietyForm
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations
  
    attr_accessor :name, :subdomain, :contact_email, :address, :phone
  
    validates :name, :subdomain, presence: true
    validates :contact_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: false
    validates :phone, presence: true, format: { with: /\A\d{10}\z/, message: "must be a 10-digit number" }

    def initialize(attributes = {}, society: nil)
      @society = society || Society.new
      super(attributes.presence || @society.attributes.slice("name", "subdomain", "contact_email", "address", "phone"))
    end
  
    def submit
      return false unless valid?
  
      @society.assign_attributes(attributes_for_model)
      @society.save!
    end
  
    def persisted?
      @society&.persisted?
    end
  
    def to_model
      @society
    end
  
    def errors
      @society.errors
    end
  
    private
  
    def attributes_for_model
      {
        name: name,
        subdomain: subdomain,
        contact_email: contact_email,
        address: address,
        phone: phone
      }
    end
  end
  