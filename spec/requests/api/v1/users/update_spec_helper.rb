def update_user_successful_body
  {
    user:
      {
        time_zone: "Australia/Adelaide",
      }
  }
end

def update_user_expected_attributes
  {
    username: user1.username,
    time_zone: "Australia/Adelaide",
    slug: user1.slug,
    account_level: user1.account_level,
    avatar: nil
  }
end