def user_show_successful_url
  "/api/v1/users/#{user1.slug}"
end

def user_show_unsuccessful_url
  "/api/v1/users/not-an-actual-slug"
end

def user_show_guest_url
  "/api/v1/users/guest-1"
end

def user_show_expected_attributes
  {
    username: user1.username,
    slug: user1.slug,
    level: "member",
    avatar: nil
  }
end