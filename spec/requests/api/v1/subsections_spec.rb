require 'rails_helper'

subsection1_data = {
  id: "1",
  type: "subsection",
  attributes: {
    section_id: 1,
    title: "First Subsection"
  }
}

RSpec.describe "Api::V1::Subsections", type: :request do

  describe "GET index" do
    it "returns http success" do
      get "/api/v1/subsections"
      expect(response).to have_http_status(:success)
    end
    it "returns data" do
      get "/api/v1/subsections"
      expect(data.length).to eq(3)
      expect(data[0]).to eq(subsection1_data)
    end
  end

  describe "POST create" do
    it "returns http created and creates a new subsection" do
      body = {
        "subsection": {
          "title": "Test Subsection"
        }
      }
      headers = {
        "Authorization": user1_auth
      }
      post "/api/v1/sections/1/subsections", params: body, headers: headers
      expect(response).to have_http_status(:created)
      expect(Subsection.last.title).to eq('Test Subsection')
      expect(Subsection.count).to eq(4)
    end
  end

end
