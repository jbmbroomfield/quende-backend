def user_create_successful_body
  {
    user: {
      username: "Test Request Create User",
      password: "test-pass",
      email_address: "test@email.com"
    }
  }
end

def user_create_expected_attributes
  {
    username: "Test Request Create User",
    slug: "test-request-create-user",
    avatar: nil,
    level: "member",
  }
end

def user_create_existing_username_body
  {
    user: {
      username: user1.username.downcase,
      password: "test-pass",
      email_address: "test@email.com"
    }
  }
end