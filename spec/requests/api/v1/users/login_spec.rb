require "rails_helper"
require "requests/api/v1/users/helpers/login_spec_helper"

url = "/api/v1/login"

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST /login" do

    it "returns http create and a jwt token" do
			post url, params: login_success_body
			expect(response).to have_http_status(:ok)
			expect(jwt).to eq(user1_jwt)
			attributes = json[:user][:data][:attributes]
			expect(attributes).to eq(user1_attributes)
  	end

		it "rejects an incorrect username" do
			post url, params: login_incorrect_username_body
			expect(response).to have_http_status(:unauthorized)
			expect(json).to eq({
				errors: {
					error: "Invalid username or password."
				}
			})
		end

		it "rejects an incorrect password" do
			post url, params: login_incorrect_password_body
			expect(response).to have_http_status(:unauthorized)
			expect(json).to eq({
				errors: {
					error: "Invalid username or password."
				}
			})
		end

  end
end
