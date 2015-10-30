require 'rails_helper'

RSpec.describe Answer, type: :model do
     let(:question){ Question.create(title: "Q1", body:"Q1 Text", resolved:false)}
     let(:answer){Answer.create!(body: "Answer1 Body", question: question) }
     
     describe "When defining attributes" do
        it "Should respond to body" do
            expect(answer).to respond_to(:body)
        end
     end
end
