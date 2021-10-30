require 'rails_helper'

user_topic1_attributes = {
  topic_id: 1,
  subscribed: false
}

RSpec.describe "Api::V1::UserTopics", type: :request do

  describe "GET show" do
    it "returns http success and correct data" do
      headers = {
        "Authorization": user1_auth
      }
      get "/api/v1/user_topics/1", headers: headers
      expect(response).to have_http_status(:success)
      expect(data[:attributes]).to eq(user_topic1_attributes)
    end
  end

end
