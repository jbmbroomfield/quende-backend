def user1
  User.first
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
  json && json[:data]
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
    time_zone: user1.time_zone,
    slug: user1.slug,
    account_level: user1.account_level,
    avatar: nil,
  }
end