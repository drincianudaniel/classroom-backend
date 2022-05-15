class AssignmentsController < ApplicationController
    before_action :validate_user
    def showAll
        @assignments = Assignment.all
           if @assignments
              render json: {
              assignments: @assignments
           }
          else
              render json: {
              status: 500,
              errors: ['no assignments found']
          }
        end
    end

    def createAssignment
        @assignment = Assignment.new(assignment_params)
        if @assignment.save
            render json: {
            status: :created,
            assignment: @assignment
        }
        usersid = @assignment.classroom.userclassrooms.pluck(:user_id)
        
        usersid.each{
            |u| Userassignment.create(user_id: u, assignment_id: @assignment.id)
        }
        else 
            render json: {
            status: 500,
            errors: @assignment.errors.full_messages
        }
        end
    end

    def deleteAssignment
        @assignment = Assignment.find(params[:id])
        if @assignment.destroy
            render json: {
                status: :deleted,
                assignment: @assignment
            }
            else 
                render json: {
                status: 500,
                errors: @assignment.errors.full_messages
            }
        end
    end
        

    private
    def assignment_params
        params.require(:assignment).permit(:classroom_id, :name, :details)
    end
end
