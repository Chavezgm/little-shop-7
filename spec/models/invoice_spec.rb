require 'rails_helper'

RSpec.describe Invoice, type: :model do
   describe 'relationships' do
      it { should belong_to :customer }
      it { should have_many :transactions }
      it { should have_many :invoice_items }
      it { should have_many(:items).through(:invoice_items) }
      it { should have_many(:merchants).through(:items) }
   end

   describe '#incomplete_invoices' do
      it 'return the invoices that have status pending or packaged' do
         customer_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
         customer_2 = create(:customer, first_name: "John", last_name: "Smith")
         customer_3 = create(:customer, first_name: "Jane", last_name: "Perry")
         customer_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
         customer_5 = create(:customer, first_name: "Patrick", last_name: "Karl")
         
         green_merchant = Merchant.create!(name: "Green Inc")
         black_merchant = Merchant.create!(name: "Black Inc")
         brown_merchant = Merchant.create!(name: "Brown Inc")
         
         item1 = create(:item, name: "table", merchant_id: green_merchant.id)
         item2 = create(:item, name: "pen", merchant_id: black_merchant.id)
         item3 = create(:item, name: "paper", merchant_id: brown_merchant.id)
         
         invoice1 = create(:invoice, customer_id: customer_1.id, status: 1)
         invoice6 = create(:invoice, customer_id: customer_1.id, status: 1)
         
         invoice2 = create(:invoice, customer_id: customer_2.id, status: 1)
         invoice7 = create(:invoice, customer_id: customer_2.id, status: 1)
         invoice8 = create(:invoice, customer_id: customer_2.id, status: 1)
         
         
         invoice3 = create(:invoice, customer_id: customer_3.id, status: 1)
         
         invoice4 = create(:invoice, customer_id: customer_5.id, status: 1)
         invoice5 = create(:invoice, customer_id: customer_5.id, status: 1)
         invoice9 = create(:invoice, customer_id: customer_5.id, status: 1)
         invoice10 = create(:invoice, customer_id: customer_5.id, status: 1)
         
         transaction1 = create(:transaction, invoice: invoice1, result: 0)
         transaction2 = create(:transaction, invoice: invoice2, result: 0)
         transaction3 = create(:transaction, invoice: invoice3, result: 0)
         transaction4 = create(:transaction, invoice: invoice4, result: 0)
         transaction5 = create(:transaction, invoice: invoice5, result: 0)
         transaction6 = create(:transaction, invoice: invoice6, result: 0)
         transaction7 = create(:transaction, invoice: invoice7, result: 0)
         transaction8 = create(:transaction, invoice: invoice8, result: 0)
         transaction9= create(:transaction, invoice: invoice9, result: 0)
         transaction10 = create(:transaction, invoice: invoice10, result: 0)   
      end
   end

   # describe "instance methods" do
   #    it "#formatted_date" do
   #       @cust_1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
   #       @invoice1 = Invoice.create!(customer_id: @cust_1.id, status: 1)
   #       expect(@invoice1.created_at.formatted_date).to eq("Wednesday, February 28, 2024")
   #    end
   # end
end