class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :wing, optional: true
  delegate :super_admin?, :admin?, :member?, to: :role, allow_nil: true

  #belongs_to :society, through: :wing
  belongs_to :role
end
