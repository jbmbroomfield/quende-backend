require 'rails_helper'

user_topic1_attributes = {
  user_id: 1,
  topic_id: 1,
  subscribed: false
}
user_topic1_attributes_subscribed = {
  user_id: 1,
  topic_id: 1,
  subscribed: true
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

  describe "POST subscribe" do
    it "returns http success and subscribes" do
      headers = {
        "Authorization": user1_auth
      }
      params = { "subscribed": true }
      post "/api/v1/user_topics/1/subscribe", headers: headers, params: params
      expect(response).to have_http_status(:success)
      expect(data[:attributes]).to eq(user_topic1_attributes_subscribed)
      expect(UserTopic.first.subscribed).to eq(true)
    end
  end

  describe "POST unsubscribe" do
    it "returns http success and unsubscribes" do
      headers = {
        "Authorization": user1_auth
      }
      params = { "subscribed": false }
      user_topic = UserTopic.create(user_id: 1, topic_id: 1, subscribed: true)
      post "/api/v1/user_topics/1/subscribe", headers: headers, params: params
      expect(response).to have_http_status(:success)
      expect(data[:attributes]).to eq(user_topic1_attributes)
      expect(UserTopic.first.subscribed).to eq(false)
    end
  end

end
