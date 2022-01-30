module SlugHelper

  def set_slug_from_title
    initial_slug = self.title.gsub(/_/, '-').parameterize
    self.slug = append_number_to_slug(initial_slug)
  end

  def append_number_to_slug(initial_slug)
    slug = initial_slug
    number = 1
    loop do
      objects = self.class.where(slug: slug)
      if objects.count > 0
        number += 1
        slug = initial_slug + "-#{number}"
      else
        break
      end
    end
    slug
  end
  
end