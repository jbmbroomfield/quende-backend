# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
    {
        username: 'Jim',
        email: 'jimbroomy@hotmail.com',
        account_level: 'admin',
        password_authentication_attributes: {
            password: 'bob',
            password_confirmation: 'bob',
        },
    },
    {
        username: 'Alice',
        email: 'alice@alice.com',
        account_level: 'user',
        password_authentication_attributes: {
            password: 'bob',
            password_confirmation: 'bob',
        },
    },
    {
        username: 'Bob',
        email: 'bob@bob.com',
        account_level: 'user',
        password_authentication_attributes: {
            password: 'bob',
            password_confirmation: 'bob',
        },
    },
])

Section.create([
    {title: 'First Section'},
    {title: 'Second Section'},
    {title: 'Third Section'},
])

Subsection.create([
    {
        title: 'First Subsection',
        section_id: 1,
    },
    {
        title: 'Second Subsection',
        section_id: 1,
    },
    {
        title: 'Third Subsection',
        section_id: 2,
    },
    {
        title: 'Fourth Subsection',
        section_id: 3,
    },
])

Topic.create([
    {
        title: 'First Topic',
        subsection_id: 1,
    },
    {
        title: 'Second Topic',
        subsection_id: 1,
    },
    {
        title: 'Third Topic',
        subsection_id: 2,
    },
])

Post.create([
    {
        user_id: 1,
        topic_id: 1,
        text: 'First Post',
    },
    {
        user_id: 2,
        topic_id: 1,
        text: 'Second Post',
    },
    {
        user_id: 2,
        topic_id: 2,
        text: 'Third Post',
    },
])