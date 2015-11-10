require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:my_question){Question.create!(title: "Default Title", body: "Default Body", resolved:false)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_question] to @questions" do
      get :index
      expect(assigns(:questions)).to eq([my_question])
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, {id: my_question.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_question.id}
      expect(response).to render_template :show
    end

    it "assigns my_question to @question" do
      get :show, {id: my_question.id}
      expect(assigns(:question)).to eq(my_question)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @question" do
      get :new
      expect(assigns(:question)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increase the number of question by 1" do
      expect{ post :create, {question: {title: "Test Title", description: "Test body"}}}.to change(Question,:count).by(1)
      #expect{ question :create, {question: {title: "Test Title", body: "Test Body", resolved: false}}.to change(Question, :count).by(1)
    end

    it "assigns the new question to @question" do
      #post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
      post :create, {question: {title: "Test Title", body: "Test Body", resolved: false}}
      expect(assigns(:question)).to eq Question.last
    end

    it "redirects to the new question" do
      post :create, {question: {title: "Test Title", body: "Test Body", resolved: false}}
      expect(response).to redirect_to Question.last
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_question.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: my_question.id}
      expect(response).to render_template :edit
    end

    it "assigns question to be updated to @question" do
      get :edit, {id: my_question.id}

      question_instance = assigns(:question)

      expect(question_instance.id).to eq my_question.id
      expect(question_instance.title).to eq my_question.title
      expect(question_instance.body).to eq my_question.body
      expect(question_instance.resolved).to eq my_question.resolved
    end
  end

  describe "PUT update" do
    it "update question with expected attributes" do
      new_title = "New Test Title"
      new_body = "New Test Body"
      new_resolved = 0

      puts ">>>>>>>>>>>>> my_question: #{my_question.inspect}"

      put :update, id: my_question.id, question: {title: new_title, body: new_body, resolved: new_resolved}


      puts ">>>>>>>>>>>>> my_question after: #{my_question.inspect}"
      updated_question = assigns(:question)
      puts ">>>>>>>> updated_question: #{updated_question.inspect}"
      expect(updated_question.id).to eq my_question.id
      expect(updated_question.title).to eq my_question.title
      expect(updated_question.body).to eq my_question.body
      expect(updated_question.resolved).to eq my_question.resolved
    end

    it "redirects to the updated question" do
      new_title = "New Test Title"
      new_body = "New Test Body"
      new_resolved = 0

      put :update, id: my_question.id, question: {title: new_title, body: new_body, resolved: new_resolved}
      expect(response).to redirect_to my_question
    end
  end

  describe "DELETE destroy" do
    it "deletes the question" do
      delete :destroy, {id: my_question.id}

      count = Question.where({id:my_question.id}).size
      expect(count).to eq 0
    end

    it "redirects tot questions index" do
      delete :destroy, {id: my_question.id}

      expect(response).to redirect_to questions_path
    end
  end
end
