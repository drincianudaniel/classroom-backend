class ClassroomsController < ApplicationController
    before_action :validate_user

    def showAll
        @classrooms = Classroom.all
           if @classrooms
              render json: {
              classrooms: @classrooms
           }
          else
              render json: {
              status: 500,
              errors: ['no classrooms found']
          }
        end
    end

    def createClass
        @classroom = Classroom.new(classroom_params)
        if @classroom.save
            render json: {
            status: :created,
            classrooms: @classroom
        }
        else 
            render json: {
            status: 500,
            errors: @classroom.errors.full_messages
        }
        end
    end

    def deleteClass
        @classroom = Classroom.find(params[:id])
        if @classroom.destroy
            render json: {
                status: :deleted,
                classrooms: @classroom
            }
            else 
                render json: {
                status: 500,
                errors: @classroom.errors.full_messages
            }
        end
    end

    private
    def classroom_params
        params.require(:classrooms).permit(:name, :details)
    end
    
end
