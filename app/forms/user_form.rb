class UserForm
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations
  
    attr_accessor :name, :email, :phone, :password, :password_confirmation, :role_id
  
    validates :name, :email, :phone, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone, format: { with: /\A\d{10}\z/, message: "must be a 10-digit number" }
    validates :password, confirmation: true, if: -> { password.present? }
  
    def initialize(attributes = {}, user: nil)
      @user = user || User.new
      super(attributes.presence || @user.attributes.slice("name", "email", "phone"))
    end
  
    def submit
      return false unless valid?
  
      @user.assign_attributes(attributes_for_model)
      @user.save
    end
  
    def persisted?
      @user&.persisted?
    end
  
    def to_model
      @user
    end
  
    def errors
      @user.errors
    end
  
    private
  
    def attributes_for_model
      {
        name: name,
        email: email,
        phone: phone,
        role_id: role_id,
        password: password.presence,
        password_confirmation: password_confirmation.presence
      }
    end
  end
  