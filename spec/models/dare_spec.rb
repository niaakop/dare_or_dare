require 'rails_helper'

RSpec.describe Dare, type: :model do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }
  
  context 'when there is text' do
    let(:dare) { build(:dare, text: 'Sample dare', template: 'Sample template', user: user) }

    it 'is valid' do
      expect(dare).to be_valid
    end
  end

  context 'when there is no text' do 
    let(:dare) { build(:dare, template: 'Sample template', user: user) }
    
    it 'is not valid' do
      expect(dare).to_not be_valid
    end
  end
end
