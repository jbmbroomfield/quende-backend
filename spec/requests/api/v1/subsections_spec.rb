require 'rails_helper'

subsection1_data = {
  id: "1",
  type: "subsection",
  attributes: {
    title: "First Subsection"
  }
}

RSpec.describe "Api::V1::Subsections", type: :request do

  describe "GET index" do
    it "returns http success" do
      get "/api/v1/sections/1/subsections"
      expect(response).to have_http_status(:success)
    end
    it "returns data" do
      get "/api/v1/sections/1/subsections"
      json = JSON.parse(response.body).deep_symbolize_keys
      data = json[:data]
      expect(data.length).to eq(2)
      expect(data[0]).to eq(subsection1_data)
    end
  end

  # describe "GET show" do
  #   it "returns http success" do
  #     get "/api/v1/subsections/1"
  #     expect(response).to have_http_status(:success)
  #   end
  #   it "returns data" do
  #     get "/api/v1/subsections/1"
  #     json = JSON.parse(response.body).deep_symbolize_keys
  #     data = json[:data]
  #     expect(data).to eq(subsection1_data)
  #   end
  # end

end
