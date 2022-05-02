class Classroom < ActiveRecord::Base
    # has_and_belongs_to_many :users
    has_many :userclassrooms
    has_many :users, through: :userclassrooms
    
    has_many :assignments
end
