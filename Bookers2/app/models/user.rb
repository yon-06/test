class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name,uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :authentication_keys => [:name]

         has_many :books, dependent: :destroy

         attachment :profile_image

         validates :name, presence: true, length: { in: 2..20 }
         validates :introduction, length: { maximum: 50 }

         def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

 def email_required?
   false
 end
 def email_changed?
   false
 end
end
