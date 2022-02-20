require "rails_helper"
require "requests/api/v1/forums/helpers/index_spec_helper"

url = "/api/v1/forums"

RSpec.describe "Api::V1::Forums", type: :request do
  describe "GET /forums" do

    it "returns an array of all forums" do
      get url
      expect(response).to have_http_status(:ok)
      expect(data.length).to eq(Forum.count)
      expect(data[0][:attributes]).to eq(forum1_attributes)
      expect(data[1][:attributes]).to eq(forum2_attributes)
    end
    
  end
end