require 'rails_helper'

RSpec.describe "Api::V1::Auths", type: :request do
  describe "POST /login" do
    it "returns http create and a jwt token" do
		body = {
			"user": {
				"username": "Jim",
				"password_authentication_attributes": {
					"password": "bob"
				}
			}
		}
      	post "/api/v1/login", params: body
      	expect(response).to have_http_status(:success)
		expect(jwt).to eq(user1_jwt)
  	end
  end
end
