require "rails_helper"
require "requests/api/v1/forums/helpers/create_spec_helper"

url = "/api/v1/forums"

RSpec.describe "Api::V1::Forums", type: :request do
  describe "POST /forums" do
  
    it "requires the user to be logged in" do
      post url, params: forum_create_successful_body
      expect(response).to have_http_status(:unauthorized)
      expect(json).to eq(require_login_response)
    end

    it "creates and returns a new forum" do
      post url, headers: user1_headers, params: forum_create_successful_body
      expect(response).to have_http_status(:created)
      expect(attributes).to eq(forum_create_expected_attributes)
      forum = Forum.find_by(slug: forum_create_expected_attributes[:slug])
      expect(forum.super_admin?(user1)).to eq(true)
      expect(forum.super_admin?(user2)).to eq(false)
      expect(forum.super_admins.count).to eq(1)
      expect(forum.admins.count).to eq(1)
    end

    it "rejects a title with the same slug as a pre-existing title" do
      post url, headers: user1_headers, params: forum_create_existing_title_body
      expect(response).to have_http_status(:forbidden)
      expect(json).to eq(forum_create_existing_title_response)
    end

  end
end