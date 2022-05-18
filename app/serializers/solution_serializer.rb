class SolutionSerializer < ActiveModel::Serializer
  attributes :id, :assignment_id, :grade, :solution_content
  attribute :user do 
    object.user
  end
end
