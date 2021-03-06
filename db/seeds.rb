# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Faker::UniqueGenerator.clear

User.create([
  {
    username: 'Jim',
    password: 'bob',
    email_address: 'jim@mail.com',
  },
  {
    username: 'Alice',
    password: 'bob',
    email_address: 'alice@mail.com',
  },
  {
    username: 'Bob',
    password: 'bob',
    email_address: 'bob@mail.com',
  },
])

Forum.create([
  {title: 'First Forum'},
  {title: 'Second Forum'},
  {title: 'Third Forum'},
])


def rand_user
  User.create(
    username: Faker::Superhero.unique.name,
    password: 'bob',
    email_address: 'hi@mail.com'
  )
end

def rand_post(topic)
  Post.create(
    topic: topic,
    user_id: rand(User.count) + 1,
    text: Faker::Lorem.paragraph(sentence_count: 1, random_sentences_to_add: 9),
  )
end

def rand_topic(subsection)
  user_id = rand(User.count) + 1
  topic = Topic.create(
    title: Faker::Lorem.sentence(word_count: 1, random_words_to_add: 4),
    subsection: subsection,
    user_id: rand(User.count) + 1,
    who_can_view: 'anyone',
    who_can_post: 'anyone',
    guest_access: 'view',
    status: 'published',
  )
  10.times do
    rand_post(topic)
  end
end

def rand_subsection(section)
  subsection = Subsection.create(title: Faker::App.name, section: section)
  # if subsection.id > 1
    3.times do
      rand_topic(subsection)
    end
  # end
end

def rand_section
  section = Section.create(title: Faker::ProgrammingLanguage.unique.name)
  3.times do
    rand_subsection(section)
  end
end

# 7.times do
#   rand_user
# end

# 3.times do
#   rand_section
# end

# topic = Topic.first
# 180.times do
#   rand_post(topic)
# end

# who_can_views = ['anyone', 'url', 'add']
# who_can_posts = ['anyone', 'password', 'add']
# guest_accesses = [nil, 'view', 'post']

# section = Section.first
# subsection = section.subsections.first
# user = User.all[1]

# who_can_views.each do |who_can_view|
#   who_can_posts.each do |who_can_post|
#     guest_accesses.each do |guest_access|
#       if !(guest_access && who_can_view == 'add') && !(guest_access == 'post' && who_can_post == 'add')
#         title = "View: #{who_can_view}, Post: #{who_can_post}, Guests: #{guest_access || 'none'}"
#         password = who_can_post == 'password' ? '123' : nil
#         topic = Topic.create(user: user, subsection: subsection, title: title, who_can_view: who_can_view, who_can_post: who_can_post, guest_access: guest_access, password: password)
#         Post.create(user: user, topic: topic, text: title)
#       end
#     end
#   end
# end