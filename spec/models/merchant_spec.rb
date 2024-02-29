require 'rails_helper'

RSpec.describe Merchant, type: :model do
   describe 'relationships' do
      it { should have_many :items }
      it { should have_many(:invoice_items).through(:items)}
      it { should have_many(:invoices).through(:invoice_items) }
      it { should have_many(:customers).through(:invoices) }
   end

   it "top_5_customers" do
      green_merchant = Merchant.create!(name: "Green Inc")
      @black_merchant = Merchant.create!(name: "Black Inc")
      @brown_merchant = Merchant.create!(name: "Brown Inc")
      
      item1 = FactoryBot.create(:item, name: "table", merchant_id: @green_merchant.id)
      item2 = FactoryBot.create(:item, name: "pen", merchant_id: @green_merchant.id)
      item3 = FactoryBot.create(:item, name: "paper", merchant_id: @green_merchant.id)

      @cust_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
      @cust_2 = create(:customer, first_name: "John", last_name: "Smith")
      @cust_3 = create(:customer, first_name: "Jane", last_name: "Perry")
      @cust_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
      @cust_5 = create(:customer, first_name: "Patrick", last_name: "Karl")
      @cust_6 = Customer.create(first_name: "rick", last_name: "l") 
      invoice1 = FactoryBot.create(:invoice, customer_id: @cust_1.id, status: 1)  #cust1 = 21
      invoice6 = FactoryBot.create(:invoice, customer_id: @cust_1.id, status: 1)
      
      invoice2 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 1)
      invoice7 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 1)  #cust2 = 24
      invoice8 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 1)
      
      
      invoice3 = FactoryBot.create(:invoice, customer_id: @cust_3.id, status: 1)  #cust_3 = 16
      
      invoice4 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
      invoice5 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
      invoice9 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)  #cust_5 = 27
      invoice10 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
      
      transaction10 = FactoryBot.create(:transaction, invoice: invoice10, result: 1)  #cust_5 = 27 successful transactions and 1 is unsuccessful so it should still give us 27 successful transactions 

      expect(@green_merchant.top_five_customers).to eq([@cust_5,@cust_2,@cust_1,@cust_3,@cust_4])
      expect(@green_merchant.top_five_customers).to_not eq([@cust_6])
   end

   it "#pending_items" do
      merchant1 = create(:merchant) 
      merchant2 = create(:merchant)

      merchant1_items = create_list(:item, 5, merchant: merchant1)
      merchant2_items = create_list(:item, 5, merchant: merchant2)
      create(:invoice_item, item: merchant1_items[0], status: "pending")
      create(:invoice_item, item: merchant1_items[1], status: "packaged")
      create(:invoice_item, item: merchant1_items[2], status: "pending")
      create(:invoice_item, item: merchant1_items[3], status: "shipped")
      create(:invoice_item, item: merchant1_items[4], status: "shipped")

      create(:invoice_item, item: merchant2_items[0], status: "pending")
      create(:invoice_item, item: merchant2_items[1], status: "shipped")
      create(:invoice_item, item: merchant2_items[2], status: "packaged")
      create(:invoice_item, item: merchant2_items[3], status: "shipped")
      create(:invoice_item, item: merchant2_items[4], status: "shipped")

      # expect(merchant1.shipable_items).to eq([merchant1_items[0], merchant1_items[1], merchant1_items[2]])

      # expect(merchant2.shipable_items).to eq([merchant2_items[0], merchant2_items[2]])

   end
end

