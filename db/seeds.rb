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
            password: 'jimjim',
            password_confirmation: 'jimjim',
        },
    },
    {
        username: 'Alice',
        email: 'alice@alice.com',
        account_level: 'user',
        password_authentication_attributes: {
            password: 'alice',
            password_confirmation: 'alice',
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
])