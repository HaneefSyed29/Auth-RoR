class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         attr_accessor :phone_number, :address

         def vendor?
          role == 'vendor'
        end
      
        def visitor?
          role == 'visitor'
        end

        
end
