require "rails_helper"

RSpec.describe AssignmentsController, type: :controller do
    before(:each) do
      @user = User.create(name: 'admin', email:'admin@gmail.com', user_type:'Teacher', password: '123')
      session[:user_id] = @user.id
      @class = Classroom.create(name:'Math', details:'math class')
      @assignment=Assignment.create(name:'Math Homework', details:'Do ex', classroom_id:@class.id)
    end
    
    describe 'Assignments tests' do
        it 'Create assignment' do
           post :createAssignment, params:{assignment:{name:'test', details:'test details', classroom_id:@class.id}}
           data = JSON.parse(response.body)
           expect(response.status).to eq(200)
           expect(Assignment.count).to eq(2)
        end

        it 'Edit Assignment' do
            patch :editAssignment, params:{id:@assignment.id, name:'testedit', details:'test details edited'}
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
            @assignment.reload
            expect(@assignment.details).to eq('test details edited')
        end

        it 'Delete Assignment' do
            delete :deleteAssignment, params:{id:@assignment.id}
            data = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(Assignment.count).to eq(0)
        end
    end
end