require "rails_helper"

RSpec.describe "Api::V1::Auths", type: :request do
  describe "POST /login" do

    it "returns http create and a jwt token" do
			body = {
				"user": {
					"username": user1.username,
					"password_authentication_attributes": {
						"password": user1_password
					}
				}
			}
			post "/api/v1/login", params: body
			expect(response).to have_http_status(:success)
			expect(jwt).to eq(user1_jwt)
			attributes = json[:user][:data][:attributes]
			expect(attributes).to eq(user1_attributes)
  	end

		it "rejects an incorrect username" do
			body = {
				"user": {
					"username": "fdsohdisvgh",
					"password_authentication_attributes": {
						"password": user1_password
					}
				}
			}
			post "/api/v1/login", params: body
			expect(response).to have_http_status(:unauthorized)
		end

		it "rejects an incorrect password" do
			body = {
				"user": {
					"username": user1.username,
					"password_authentication_attributes": {
						"password": "incorrect password"
					}
				}
			}
			post "/api/v1/login", params: body
			expect(response).to have_http_status(:unauthorized)
		end

  end
end
