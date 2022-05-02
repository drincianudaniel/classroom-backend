class AssignmentsController < ApplicationController
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
end
