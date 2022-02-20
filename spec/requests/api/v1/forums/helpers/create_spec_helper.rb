def forum_create_successful_body
  {
    forum: {
      title: "Test Request Create Forum",
    }
  }
end

def forum_create_expected_attributes
  {
    title: "Test Request Create Forum",
    slug: "test-request-create-forum",
  }
end

def forum_create_existing_title_body
  {
    forum: {
      title: forum1.title.upcase,
    }
  }
end

def forum_create_existing_title_response
  {
    errors: {
        "forum-create-title-input": "Title unavailable."
    }
  }
end