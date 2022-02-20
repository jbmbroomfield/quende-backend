def user1
  User.find_by(username: "Jim")
end

def user2
  User.find_by(username: "Alice")
end

def user1_password
  "bob"
end

def user1_jwt
  "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.NymJjBH1jd4Hs4xBGgEKussqkkIcqmpT834F5zfEY0o"
end

def user1_auth
  "Bearer #{user1_jwt}"
end

def user1_headers
  headers = {
    "Authorization": user1_auth
  }
end

def user2_jwt
  "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.HODNacMYMYyuASAh560au8tt3zV2kaVJHmI0oXYzBrU"
end

def user2_auth
  "Bearer #{user2_jwt}"
end

def json
  JSON.parse(response.body).deep_symbolize_keys
end

def data
  json && (json[:data] || json[:user][:data])
end

def attributes
  data && data[:attributes]
end

def jwt
  json && json[:jwt]
end

def user1_attributes
  {
    username: user1.username,
    slug: user1.slug,
    avatar: nil,
    guest: false
  }
end

def user2_attributes
  {
    username: user2.username,
    slug: user2.slug,
    avatar: nil,
    guest: false
  }
end

def require_login_response
  {
    message: "Please log in."
  }
end

def forum1
  Forum.first
end

def forum2
  Forum.all[1]
end

def forum1_attributes
  {
    title: forum1.title,
    slug: forum1.slug,
  }
end

def forum2_attributes
  {
    title: forum2.title,
    slug: forum2.slug,
  }
end