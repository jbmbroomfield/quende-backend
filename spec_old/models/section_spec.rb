require 'rails_helper'

RSpec.describe Section, type: :model do
  it 'can be created' do
    section = Section.create(title: 'Test Section')
    expect(section.save).to eq(true)
  end
end
