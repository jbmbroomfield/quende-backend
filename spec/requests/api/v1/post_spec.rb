require 'rails_helper'

post1_attributes = {
  user_id: 1,
  text: "First Post",
  tag: nil
}

RSpec.describe "Api::V1::Posts", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/topics/1/posts"
      expect(response).to have_http_status(:success)
    end
    it "returns data" do
      get "/api/v1/topics/1/posts"
      expect(data.length).to eq(2)
      expect(data[0][:attributes]).to eq(post1_attributes)
    end
  end

  describe "POST create" do
    it "returns http created and creates a new topic" do
      body = {
        "post": {
          "text": "Test Post",
        }
      }
      headers = {
        "Authorization": user2_auth
      }
      post "/api/v1/topics/1/posts", params: body, headers: headers
      expect(response).to have_http_status(:created)
      expect(Post.last.text).to eq('Test Post')
      expect(Post.last.user.username).to eq('Alice')
      expect(Post.last.topic.title).to eq('First Topic')
      expect(Post.count).to eq(4)
    end
  end

end
