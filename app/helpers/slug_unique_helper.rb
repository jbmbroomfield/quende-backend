module SlugUniqueHelper

  def set_slug_from(value)
    self.slug = value.gsub(/_/, '-').parameterize
  end

  def slug_must_be_unique
    if self.class.where(slug: slug).where.not(id: id).count > 0
      errors.add(:slug, "must be unique")
    end
  end

end