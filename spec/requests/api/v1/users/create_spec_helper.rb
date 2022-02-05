def user_create_successful_body
  {
    user: {
      username: "Test User",
      password: "test-pass",
      email_address: "test@email.com"
    }
  }
end

def user_create_expected_attributes
  {
    username: "Test User",
    slug: "test-user",
    avatar: nil,
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