class User < ApplicationRecord
    
    has_secure_password

    validates :email, presence: true
    validates :email, uniqueness: true
    validates :email, length: { minimum: 4 }

    validates :name, presence: true
    validates :name, uniqueness: true

end
