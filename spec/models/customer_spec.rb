require 'rails_helper'

RSpec.describe Customer, type: :model do
   describe 'relationships' do
      it { should have_many :invoices }
      it { should have_many(:items).through(:invoices) }
      it { should have_many(:transactions).through(:invoices) }
   end

   before(:each) do
      @customer_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
      @customer_2 = create(:customer, first_name: "John", last_name: "Smith")
      @customer_3 = create(:customer, first_name: "Jane", last_name: "Perry")
      @customer_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
      @customer_5 = create(:customer, first_name: "Patrick", last_name: "Karl")
      
      @green_merchant = Merchant.create!(name: "Green Inc")
      @black_merchant = Merchant.create!(name: "Black Inc")
      @brown_merchant = Merchant.create!(name: "Brown Inc")
      
      item1 = create(:item, name: "table", merchant_id: @green_merchant.id)
      item2 = create(:item, name: "pen", merchant_id: @black_merchant.id)
      item3 = create(:item, name: "paper", merchant_id: @brown_merchant.id)
      
      invoice1 = create(:invoice, customer_id: @customer_1.id, status: 1)
      invoice6 = create(:invoice, customer_id: @customer_1.id, status: 1)
      
      invoice2 = create(:invoice, customer_id: @customer_2.id, status: 1)
      invoice7 = create(:invoice, customer_id: @customer_2.id, status: 1)
      invoice8 = create(:invoice, customer_id: @customer_2.id, status: 1)
      
      
      invoice3 = create(:invoice, customer_id: @customer_3.id, status: 1)
      
      invoice4 = create(:invoice, customer_id: @customer_5.id, status: 1)
      invoice5 = create(:invoice, customer_id: @customer_5.id, status: 1)
      invoice9 = create(:invoice, customer_id: @customer_5.id, status: 1)
      invoice10 = create(:invoice, customer_id: @customer_5.id, status: 1)
      
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

   describe ".top_five_customers" do
      it 'returns the top five customers by the amount of transactions' do
         expect(Customer.top_five_customers.first).to eq(@customer_5)
         expect(Customer.top_five_customers.last).to eq(@customer_4)
      end
   end

   describe "#successful_transactions_count" do
      it 'count the transactions for a specific customer' do
         expect(@customer_5.successful_transactions_count).to eq(13)
         expect(@customer_4.successful_transactions_count).to eq(5)
      end
   end


   describe '#successful_trans_count' do
      it 'counts successful transactions' do
         green_merchant = Merchant.create!(name: "Green Inc")
         black_merchant = Merchant.create!(name: "Black Inc")
         brown_merchant = Merchant.create!(name: "Brown Inc")
         
         item1 = FactoryBot.create(:item, name: "table", merchant_id: green_merchant.id)
         item2 = FactoryBot.create(:item, name: "pen", merchant_id: green_merchant.id)
         item3 = FactoryBot.create(:item, name: "paper", merchant_id: green_merchant.id)

         cust_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
         cust_2 = create(:customer, first_name: "John", last_name: "Smith")
         cust_3 = create(:customer, first_name: "Jane", last_name: "Perry") #cust_4 will have 15 successful transactions 
         cust_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
         cust_5 = create(:customer, first_name: "Patrick", last_name: "Karl")
         cust_6 = Customer.create(first_name: "rick", last_name: "l") #cust_6 will have 15 successful transactions 
         # require 'pry'; binding.pry
         #each customer that is created will have 5 invoices with it plus the ones we created below for example cust_1 has 7 invoices
         #for each  invoice it will have 3 transactions
         # 5 * 3 = 15 transactions from factory when we create a customer
         #2 * 3 = 6 transaction for eac in voice that we created which was invoice6 and invoice1 
         #then created 2 extra transactions for customer 1 for each invoice that we made 
         invoice1 = FactoryBot.create(:invoice, customer_id: cust_1.id, status: 1)  #cust1 = 21
         invoice6 = FactoryBot.create(:invoice, customer_id: cust_1.id, status: 1)
         
         invoice2 = FactoryBot.create(:invoice, customer_id: cust_2.id, status: 1)
         invoice7 = FactoryBot.create(:invoice, customer_id: cust_2.id, status: 1)  #cust2 = 24
         invoice8 = FactoryBot.create(:invoice, customer_id: cust_2.id, status: 1)
         
         
         invoice3 = FactoryBot.create(:invoice, customer_id: cust_3.id, status: 1)  #cust_3 = 16
         
         invoice4 = FactoryBot.create(:invoice, customer_id: cust_5.id, status: 1)
         invoice5 = FactoryBot.create(:invoice, customer_id: cust_5.id, status: 1)
         invoice9 = FactoryBot.create(:invoice, customer_id: cust_5.id, status: 1)  #cust_5 = 27
         invoice10 = FactoryBot.create(:invoice, customer_id: cust_5.id, status: 1)
         
         # transaction1 = FactoryBot.create(:transaction, invoice: invoice1, result: 0)
         # transaction2 = FactoryBot.create(:transaction, invoice: invoice2, result: 0)
         # transaction3 = FactoryBot.create(:transaction, invoice: invoice3, result: 0)
         # transaction4 = FactoryBot.create(:transaction, invoice: invoice4, result: 0)
         # transaction5 = FactoryBot.create(:transaction, invoice: invoice5, result: 0)
         # transaction6 = FactoryBot.create(:transaction, invoice: invoice6, result: 0)
         # transaction7 = FactoryBot.create(:transaction, invoice: invoice7, result: 0)
         # transaction8 = FactoryBot.create(:transaction, invoice: invoice8, result: 0)
         # transaction9 = FactoryBot.create(:transaction, invoice: invoice9, result: 0)
         transaction10 = FactoryBot.create(:transaction, invoice: invoice10, result: 1)  #cust_5 = 27 successful transactions and 1 is unsuccessful so it should still give us 27 successful transactions 

       expect(cust_1.successful_trans_count).to eq(7)
       expect(cust_4.successful_trans_count).to eq(5)
       expect(cust_5.successful_trans_count).to eq(9)
     end
   end

end