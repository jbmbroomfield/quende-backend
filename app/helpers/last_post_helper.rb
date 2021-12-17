module LastPostHelper

  def last_unignored_post(current_user)
    post = posts
    .filter { |post| post.topic.can_view(current_user) && !post.topic.ignored?(current_user) }
    .sort { |a, b| a.created_at <=> b.created_at }.last
    serialized_post(post, current_user)
  end

  def last_post(current_user)
    post = posts
    .filter { |post| post.topic.can_view(current_user) }
    .sort { |a, b| a.created_at <=> b.created_at }.last
    serialized_post(post, current_user)
  end

  private

  def serialized_post(post, current_user)
    post ? {
      id: post.id,
      type: 'post',
      attributes: get_attributes(post, current_user),
    } : {
      id: nil,
      type: 'post',
      attributes: {
        topic: {
          id: self.id,
          type: 'topic',
          attributes: {
            title: self.title,
            slug: self.slug,
            subsection_slug: self.class.method_defined?(:subsection) ? self.subsection.slug : self.slug,
          }
        },
        created_at_i: self.created_at.to_i,
        created_at_s: '',
        tag: nil,
        user: self.class.method_defined?(:user) ? {
          id: self.user.id,
          type: 'user',
          attributes: {
            username: self.user.username,
            slug: self.user.slug,
          },
      } : nil,
      }
    }
  end

  def get_attributes(post, current_user)
    topic = post.topic
    user = post.user
    {
      topic: {
        id: topic.id,
        type: 'topic',
        attributes: {
          title: topic.title,
          slug: topic.slug,
          subsection_slug: topic.subsection.slug,
        }
      },
      created_at_i: post.created_at.to_i,
      created_at_s: post.created_at_s(current_user),
      tag: post.tag,
      user: user ? {
        id: user.id,
        type: 'user',
        attributes: {
          username: user.username,
          slug: user.slug,
          account_level: user.account_level,
        }
      } : {
        id: 'none',
        type: 'user',
        attributes: {
          username: post.guest_name,
          account_level: 'guest',
        }
      },
    }
  end

end