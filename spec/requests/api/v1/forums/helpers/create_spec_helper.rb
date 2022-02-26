def forum_create_successful_body
  {
    forum: {
      title: "Test Request Create Forum",
      description: "The best test forum.",
    }
  }
end

def forum_create_expected_attributes
  {
    title: "Test Request Create Forum",
    slug: "test-request-create-forum",
    description: "The best test forum.",
    permissions: {},
  }
end

def forum_create_existing_title_body
  {
    forum: {
      title: forum1.title.upcase,
      description: "The best test forum.",
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