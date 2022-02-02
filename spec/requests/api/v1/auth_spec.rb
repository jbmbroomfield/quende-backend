require 'rails_helper'
require 'set'

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
		expect(attributes).to eq({
			username: user1.username,
			time_zone: user1.time_zone,
			slug: user1.slug,
			account_level: user1.account_level,
			avatar: nil,
		})
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
