require 'rails_helper'

notification1_attributes = {
  user_id: 1,
  category: 'replies',
  object_id: 1,
  number: 1
}

RSpec.describe "Api::V1::Notifications", type: :request do

  describe "GET index" do
    it "returns https success" do
      get "/api/v1/notifications", headers: user1_headers
      expect(response).to have_http_status(:success)
    end
    it "returns data" do
      Notification.create(notification1_attributes)
      get "/api/v1/notifications", headers: user1_headers
      expect(data[0][:attributes][:category]).to eq('replies')
    end
  end

  describe "DELETE destroy" do
    it "deletes the notification" do
      notification_id = Notification.create(notification1_attributes).id
      delete "/api/v1/notifications/#{notification_id}", headers: user1_headers
      expect(response).to have_http_status(:ok)
      expect(Notification.count).to eq(0)
    end
  end

end
