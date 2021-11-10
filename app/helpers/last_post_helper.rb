module LastPostHelper

  def last_post(current_user)
    post = posts.last
    post ? {
      id: post.id,
      type: 'post',
      attributes: attributes(post, current_user),
    } : ''
  end

  private

  def attributes(post, current_user)
    topic = post.topic
    {
      topic: {
        id: topic.id,
        type: 'topic',
        attributes: {
          title: topic.title,
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