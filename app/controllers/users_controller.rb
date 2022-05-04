class UsersController < ApplicationController

    def index
        @users = User.all
           if @users
            render json: ActiveModelSerializers::SerializableResource.new(
                @users,
                each_serializer: UserSerializer
              ).as_json
          else
              render json: {
              status: 500,
              errors: ['no users found']
          }
         end
    end

    def show
        @user = User.find(params[:id])
            if @user
               render json: {
               user: @user
            }
            else
               render json: {
               status: 500,
               errors: ['user not found']
             }
            end
       end

    def create
        @user = User.new(user_params)
        if @user.save
            login!  
            render json: {
            status: :created,
            user: @user
        }
        else 
            render json: {
            status: 500,
            errors: @user.errors.full_messages
        }
        end
    end
        
    def UserClassrooms
        # User.where(id:1).first.userclassrooms.where(classroom_id: 1)
        # /users/:user_id/:classroom_id
        ids = @current_user.userclassrooms.pluck(:classroom_id)
        # Classroom.where(id: ids)
        # varianta 2 \/
        # classrooms = User.where(id:1).first.userclassrooms.map { |e| e.classroom}
        @classrooms = Classroom.where(id: ids)
           if @classrooms
            render json: ActiveModelSerializers::SerializableResource.new(
            @classrooms,
            each_serializer: ClassroomSerializer
          ).as_json
          else
              render json: {
              status: 500,
              errors: ['no classrooms found']
          }
        end
    end
    
    def userAssignment
        ids = @current_user.userassignments.pluck(:assignment_id)
        @assignments = Assignment.where(classroom_id: params[:id]).where(id: ids)
        if @assignments
            render json: {
            assignments: @assignments
            }
        else
            render json: {
            status: 500,
            errors: ['no assignment found']
            }
        end    
    end
    private
     def user_params
         params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_type)
     end
     
    # def show
    #     user = User.where(id: params[:id]).first
    #     render json: user
    # end

    # def create
    #     render status: :ok if User.create!(name: params[:name], email: params[:email])
    # end

    # def showall
    #     users = User.all
    #     render json: users
    # end


    
end
