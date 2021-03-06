class UsersController < ApplicationController
    before_action :validate_user
    
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
            errors: @user.errors.full_messages
        }
        end
    end

    def update


        params['user'].each do |cheie, valoare|
            current_user[cheie.to_sym] = valoare
        end
        
        # if current_user.update(name: params["user"]["name"], password: params["user"]["password"])
        user = User.find(current_user.id)
        # if current_user.update(name: params[:name], password: params[:password])
        if current_user.save
            render json:{
                status: :updated,
                user: current_user
            }
        else
            render json: {
            errors: current_user.errors.full_messages
        }
        end
    end

    def updatePassword
        user = User.find(current_user.id)
        if current_user.update(password: params[:password])
            render json:{
                status: :updated,
                user: current_user
            }
        else
            render json: {
            errors: current_user.errors.full_messages
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
            render json: ActiveModelSerializers::SerializableResource.new(
                @assignments,
                each_serializer: AssignmentSerializer
              ).as_json
        else
            render json: {
            status: 500,
            errors: ['no assignment found']
            }
        end    
    end

    def UserSolution
        @solutions = Solution.where(assignment_id: params[:id]).where(user_id: current_user.id)
        if @solutions
            render json:{
                solutions: @solutions
            }
       else
           render json:{
               errors: @solutions.errors.full_messages
           }
       end
    end

    def addUsertoClass
        user = User.where(email: params[:email]).first
        user_classroom = Userclassroom.create(user_id: user.id, classroom_id: params[:classroom_id])
        assignments = Assignment.where(classroom_id: user_classroom.classroom.id)
        assignement_array = []
        assignments.each { |a| assignement_array << {user_id: user_classroom.user_id, assignment_id: a.id} }
        if assignement_array.empty? || Userassignment.insert_all(assignement_array)
            render json:{
                created: user_classroom
            }
        else
            render json:{
                errors: user_classroom.errors.full_messages
            }
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_type)
    end

    def user_paramsUpdate
        params.require(:user).permit(:name)
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
