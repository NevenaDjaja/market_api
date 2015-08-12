require 'spec_helper'

describe Api::V1::UsersController do
	before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

	describe "GET #show" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			get :show, id: @user.id, format: :json
		end

		it "returns the information about a reporter on a hash" do
			user_response = JSON.parse(response.body, symbolize_names: true)
			expect(user_response[:email]).to eql @user.email
		end
		it { should respond_with 200 }
	end

	describe "POST #create" do
		context "when is successfully created" do
			before(:each) do
				@user_attributes = FactoryGirl.attributes_for :user 
				post :create, { user: @user_attributes }, format: :json
			end

			it "renders the JSON representation for the user just created" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:email]).to eql(@user_attributes[:email])
			end

			it { should respond_with 201 }
		end

		context "when is not created" do
			before(:each) do
				@invalid_user_attr = { password: "123456", password_confirmation: "123456"}
				post :create, { user: @invalid_user_attr }, format: :json
			end

			it "renders an error json" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response).to have_key(:errors)
			end

			it "renders the error on why the user can't be created" do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:errors][:email]).to include "can't be blank"
			end

			it { should respond_with 422 }
		end
	end

end
