require 'rails_helper'

section1_data = {
  id: "1",
  type: "section",
  attributes: {
    title: "First Section"
  }
}

RSpec.describe "Api::V1::Sections", type: :request do

  describe "GET index" do
    it "returns http success" do
      get "/api/v1/sections"
      expect(response).to have_http_status(:success)
    end
    it "returns data" do
      get "/api/v1/sections"
      expect(data.length).to eq(3)
      expect(data[0]).to eq(section1_data)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get "/api/v1/sections/1"
      expect(response).to have_http_status(:success)
    end
    it "returns data" do
      get "/api/v1/sections/1"
      expect(data).to eq(section1_data)
    end
  end

  describe "POST create" do
    it "returns http created and creates a new section" do
      body = {
        "section": {
          "title": "Test Section"
        }
      }
      headers = {
        "Authorization": user1_auth
      }
      post "/api/v1/sections", params: body, headers: headers
      expect(response).to have_http_status(:created)
      expect(Section.count).to eq(4)
      expect(Section.last.title).to eq('Test Section')
    end
  end

end
