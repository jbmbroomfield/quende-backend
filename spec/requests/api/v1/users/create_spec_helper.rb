def create_successful_body
  {
    user: {
      username: "Test User",
      email: "test@email.com",
      password_authentication_attributes: {
        password: "test-pass",
        "password_confirmation": "test-pass"
      }
    }
  }
end

def expected_attributes
  {
    username: "Test User",
    time_zone: "UTC",
    slug: "test-user",
    account_level: "member",
    avatar: nil,
  }
end

def create_mismatched_body
  {
    user: {
      username: "Test Userzz",
      email: "test@email.com",
      password_authentication_attributes: {
        password: "test-pass",
        password_confirmation: "test-pass2"
      }
    }
  }
end

def create_existing_username_body
  {
    user: {
      username: user1.username.downcase,
      email: "test@email.com",
      password_authentication_attributes: {
        password: "test-pass",
        password_confirmation: "test-pass"
      }
    }
  }
end