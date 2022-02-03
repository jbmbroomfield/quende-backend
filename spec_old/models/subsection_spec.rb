require 'rails_helper'

RSpec.describe Subsection, type: :model do
  it 'can be created' do
    subsection = Subsection.new(title: 'Test Subsection', section_id: 1)
    expect(subsection.save).to eq(true)
  end
end
