class SolutionController < ApplicationController
    #before_action :validate_user

    def createSolution
        @solution = Solution.new(solution_params)
        @solution.user_id = current_user.id
        if @solution.save
            render json: {
            status: :created,
            solution: @solution
        }
        else 
            render json: {
            errors: @solution.errors.full_messages
        }
        end
    end


    #before_action :validate_admin, only: [:showallSolutions]
    def showallSolutions
        @solution = Solution.where(assignment_id: params[:id]).includes(:user)
        if @solution
            render json: ActiveModelSerializers::SerializableResource.new(
                @solution,
                each_serializer: SolutionSerializer
            ).as_json
        end
    end

    private
    def solution_params
        params.require(:solution).permit(:assignment_id, :solution_content)
    end
end
