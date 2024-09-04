require 'rails_helper'

RSpec.describe Dare, type: :model do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }
end
# add spec for validate template
