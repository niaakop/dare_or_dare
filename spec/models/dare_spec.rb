require 'rails_helper'

RSpec.describe Dare, type: :model do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }
  
  it 'is valid with valid attributes' do
    dare = Dare.new(text: 'Sample dare', template: 'Sample template', user: user)
    expect(dare).to be_valid
  end

  it 'is not valid without text' do
    dare = Dare.new(template: 'Sample template', user: user)
    expect(dare).to_not be_valid
  end
end
