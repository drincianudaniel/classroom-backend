class Assignment < ActiveRecord::Base
    has_many :userassignments
    has_many :users, through: :userassignments

    belongs_to :classroom

    has_many :solutions
end
