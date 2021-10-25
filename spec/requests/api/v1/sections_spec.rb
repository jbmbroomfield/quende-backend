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
      json = JSON.parse(response.body).deep_symbolize_keys
      data = json[:data]
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
      json = JSON.parse(response.body).deep_symbolize_keys
      data = json[:data]
      expect(data).to eq(section1_data)
    end
  end

end
