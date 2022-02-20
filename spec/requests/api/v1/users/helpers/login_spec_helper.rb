def login_success_body
  {
    "user": {
      "username": user1.username,
      "password": user1_password,
    }
  }
end

def login_incorrect_username_body
  {
    "user": {
      "username": "fdsohdisvgh",
      "password": user1_password,
    }
  }
end

def login_incorrect_password_body
  {
    "user": {
      "username": user1.username,
      "password": "incorrect password",
    }
  }
end