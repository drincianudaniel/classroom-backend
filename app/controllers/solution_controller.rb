class SolutionController < ApplicationController
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

    def showallSolutions
        @solution = Solution.where(assignment_id: params[:id])
        if @solution
            render json:
            {
                solutions: @solution
            }
        end
    end

    private
    def solution_params
        params.require(:solution).permit(:assignment_id, :solution_content)
    end
end
