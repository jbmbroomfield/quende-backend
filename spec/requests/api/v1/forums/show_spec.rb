require "rails_helper"
require "requests/api/v1/forums/helpers/show_spec_helper"

url = "/api/v1/forums"

RSpec.describe "Api::V1::Forums", type: :request do
  describe "GET /forums" do

    it "returns the requested forum" do
      get forum_show_successful_url
      expect(response).to have_http_status(:ok)
      expect(attributes).to eq(forum1_attributes)
    end

    it "returns not found if the slug does not belong to a forum" do
      get forum_show_unsuccessful_url
      expect(response).to have_http_status(:not_found)
    end
    
  end
end