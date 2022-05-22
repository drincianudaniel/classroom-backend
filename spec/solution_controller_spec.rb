require "rails_helper"

RSpec.describe SolutionController, type: :controller do
    before(:each) do
      @user = User.create(name: 'admin', email:'admin@gmail.com', user_type:'Teacher', password: '123')
      session[:user_id] = @user.id
      @class = Classroom.create(name: 'admin', details: '123')
      @assignment=Assignment.create(name:'Math Homework', details:'Do ex', classroom_id:@class.id)
      @solution =Solution.create(user_id: @user.id, assignment_id: @assignment.id, solution_content:'wefwefiwejkwf')
    end

    describe 'Class tests' do
        it 'Create solution' do
           post :createSolution, params:{solution:{user_id: @user.id, assignment_id: @assignment.id,solution_content: 'admin132', grade: 90}}
           data = JSON.parse(response.body)
           expect(response.status).to eq(200)
        end
      
        it 'Edit Solution' do
          patch :editSolutions, params:{id:@solution.id, grade:55}
          data = JSON.parse(response.body)
          expect(response.status).to eq(200)
          @solution.reload
          expect(@solution.grade).to eq(55)
      end
    end
end