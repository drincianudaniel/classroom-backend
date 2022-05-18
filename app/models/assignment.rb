class Assignment < ActiveRecord::Base
    has_many :userassignments, dependent: :destroy
    has_many :users, through: :userassignments

    belongs_to :classroom

    has_many :solutions, dependent: :destroy
end
