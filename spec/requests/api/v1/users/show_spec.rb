require "rails_helper"
require "requests/api/v1/users/helpers/show_spec_helper"

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /show" do
  
    it "returns the requested user" do
      get user_show_successful_url
      expect(response).to have_http_status(:ok)
      expect(data).to eq(user_show_expected_attributes)
    end

    it "returns not found if the slug does not belong to a user" do
      get user_show_unsuccessful_url
      expect(response).to have_http_status(:not_found)
    end

  end
end