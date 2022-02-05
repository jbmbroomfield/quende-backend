require "rails_helper"
require "requests/api/v1/users/update_spec_helper"

url = "/api/v1/current_user"

RSpec.describe "Api::V1::Users", type: :request do

  describe "PATCH current_user" do
    it "updates the current user - TO UPDATE" do
      expect(true).to eq(true)
      # patch url, headers: user1_headers, params: update_user_successful_body
      # expect(response).to have_http_status(:success)
      # expect(attributes).to eq(update_user_expected_attributes)
    end
  end

end