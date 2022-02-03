def body
  {
    "user": {
      "username": user1.username,
      "password_authentication_attributes": {
        "password": user1_password
      }
    }
  }
end

def incorrect_username_body
  {
    "user": {
      "username": "fdsohdisvgh",
      "password_authentication_attributes": {
        "password": user1_password
      }
    }
  }
end

def incorrect_password_body
  {
    "user": {
      "username": user1.username,
      "password_authentication_attributes": {
        "password": "incorrect password"
      }
    }
  }
end