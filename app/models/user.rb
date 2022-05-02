class User < ActiveRecord::Base
    
    has_secure_password

    validates :email, presence: true
    validates :email, uniqueness: true
    validates :email, length: { minimum: 4 }

    validates :name, presence: true
    validates :name, uniqueness: true

    has_many :userclassrooms
    has_many :classrooms, through: :userclassrooms

    has_many :userassignments
    has_many :assignments, through: :userassignments

    has_one :solution
end
