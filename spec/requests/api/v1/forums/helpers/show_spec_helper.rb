def forum_show_successful_url
  "/api/v1/forums/#{forum1.slug}"
end

def forum_show_unsuccessful_url
  "/api/v1/forums/not-an-actual-slug"
end
