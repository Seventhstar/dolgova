class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :tarif
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  scope :only_actual, ->{where(actual: true).order(:name)}

end
