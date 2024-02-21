require 'rails_helper'

RSpec.describe Merchant, type: :model do
   describe 'relationships' do
      it { should have_many :items }
      it { should have_many(:invoices).through(:items) }
   end
end