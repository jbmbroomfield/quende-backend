module LastPostHelper

  def last_post(current_user)
    post = posts.last
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
            subsection_id: self.subsection.id,
          }
        },
        created_at_i: self.created_at.to_i,
        created_at_s: '',
        tag: nil,
        user: {
          id: self.user.id,
          type: 'user',
          attributes: {
            username: self.user.username,
          },
      },
      }
    }
  end

  private

  def get_attributes(post, current_user)
    topic = post.topic
    {
      topic: {
        id: topic.id,
        type: 'topic',
        attributes: {
          title: topic.title,
          slug: topic.slug,
          subsection_id: topic.subsection.id,
        }
      },
      created_at_i: post.created_at.to_i,
      created_at_s: post.created_at_s(current_user),
      tag: post.tag,
      user: {
        id: post.user.id,
        type: 'user',
        attributes: {
          username: post.user.username,
        },
      },
    }
  end

end