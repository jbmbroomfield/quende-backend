require 'rails_helper'
require 'models/helpers/section_spec_helper.rb'

RSpec.describe Section, type: :model do

  it 'can create a section' do
    forum = Forum.create(title: 'Test Forum', description: 'A test forum')
    section = Section.create(title: 'Test Section', forum: forum)
    expect(section.valid?).to eq(true)
    expect(section.title).to eq('Test Section')
    expect(section.forum.title).to eq('Test Forum')
  end
  
end