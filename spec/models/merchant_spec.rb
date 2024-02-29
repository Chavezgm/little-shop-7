require 'rails_helper'

RSpec.describe Merchant, type: :model do
   describe 'relationships' do
      it { should have_many :items }
      it { should have_many(:invoice_items).through(:items)}
      it { should have_many(:invoices).through(:invoice_items) }
      it { should have_many(:customers).through(:invoices) }
   end

   before(:each) do 
      @customer_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
      @customer_2 = create(:customer, first_name: "John", last_name: "Smith")
      @customer_3 = create(:customer, first_name: "Jane", last_name: "Perry")
      @customer_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
      @customer_5 = create(:customer, first_name: "Patrick", last_name: "Karl")
      
      @green_merchant = Merchant.create!(name: "Green Inc", status: 0)
      @black_merchant = Merchant.create!(name: "Black Inc", status: 1)
      @brown_merchant = Merchant.create!(name: "Brown Inc", status: 0)
      @white_merchant = Merchant.create!(name: "White Inc", status: 0)
      @blue_merchant = Merchant.create!(name: "Blue Inc", status: 1)
      @grey_merchant = Merchant.create!(name: "Grey Inc", status: 1)


      @item1 = create(:item, name: "table", merchant: @green_merchant)
      @item4 = create(:item, name: "box", merchant: @green_merchant)
      @item2 = create(:item, name: "pen", merchant: @black_merchant)
      @item5 = create(:item, name: "chair", merchant: @black_merchant)
      @item3 = create(:item, name: "paper", merchant: @brown_merchant)
      @item6 = create(:item, name: "computer", merchant: @brown_merchant)
      @item7 = create(:item, name: "door", merchant: @white_merchant)
      @item8 = create(:item, name: "glass", merchant: @white_merchant)
      @item9 = create(:item, name: "stapler", merchant: @blue_merchant)
      @item10 = create(:item, name: "paper_clip", merchant: @blue_merchant)
      @item11 = create(:item, name: "cup", merchant: @grey_merchant)
      @item12 = create(:item, name: "bottle", merchant: @grey_merchant)
      
      @invoice1 = create(:invoice, customer_id: @customer_1.id, status: 0)
      @invoice6 = create(:invoice, customer_id: @customer_1.id, status: 1)
      
      @invoice2 = create(:invoice, customer_id: @customer_2.id, status: 0)
      @invoice7 = create(:invoice, customer_id: @customer_2.id, status: 1)
      @invoice8 = create(:invoice, customer_id: @customer_2.id, status: 1)
      
      @invoice3 = create(:invoice, customer_id: @customer_3.id, status: 0)
      
      @invoice4 = create(:invoice, customer_id: @customer_5.id, status: 1)
      @invoice5 = create(:invoice, customer_id: @customer_5.id, status: 1)
      @invoice9 = create(:invoice, customer_id: @customer_5.id, status: 1)
      @invoice10 = create(:invoice, customer_id: @customer_5.id, status: 1)
      
      transaction1 = create(:transaction, invoice: @invoice1, result: 0)
      transaction2 = create(:transaction, invoice: @invoice2, result: 0)
      transaction3 = create(:transaction, invoice: @invoice3, result: 0)
      transaction4 = create(:transaction, invoice: @invoice4, result: 0)
      transaction5 = create(:transaction, invoice: @invoice5, result: 0)
      transaction6 = create(:transaction, invoice: @invoice6, result: 0)
      transaction7 = create(:transaction, invoice: @invoice7, result: 0)
      transaction8 = create(:transaction, invoice: @invoice8, result: 0)
      transaction9= create(:transaction, invoice: @invoice9, result: 0)
      transaction10 = create(:transaction, invoice: @invoice10, result: 0)
         
      @invoiceitem1 = InvoiceItem.create!(invoice: @invoice1, item: @item1, quantity: 5, unit_price: 1, status: 1 )
      @invoiceitem4 = InvoiceItem.create!(invoice: @invoice2, item: @item3, quantity: 6, unit_price: 1, status: 1 )
      @invoiceitem6 = InvoiceItem.create!(invoice: @invoice3, item: @item3, quantity: 6, unit_price: 1, status: 1 )
      @invoiceitem7 = InvoiceItem.create!(invoice: @invoice4, item: @item1, quantity: 7, unit_price: 1, status: 1 )
      @invoiceitem9 = InvoiceItem.create!(invoice: @invoice5, item: @item2, quantity: 10, unit_price: 1, status: 1 )
      @invoiceitem12 = InvoiceItem.create!(invoice: @invoice6, item: @item2, quantity: 8, unit_price: 1, status: 1 )
      @invoiceitem14 = InvoiceItem.create!(invoice: @invoice7, item: @item4, quantity: 10, unit_price: 1, status: 1 )
      @invoiceitem15 = InvoiceItem.create!(invoice: @invoice8, item: @item5, quantity: 15, unit_price: 1, status: 1 )
      @invoiceitem17 = InvoiceItem.create!(invoice: @invoice9, item: @item9, quantity: 17, unit_price: 1, status: 1 )
      @invoiceitem19 = InvoiceItem.create!(invoice: @invoice10, item: @item7, quantity: 13, unit_price: 1, status: 1 )
   end
   
   describe "#top_5_customers" do
      it "returns top 5 customers" do  

         expect(@green_merchant.top_five_customers).to eq([@customer_5,@customer_2,@customer_1,@customer_3,@customer_4])
         expect(@green_merchant.top_five_customers).to_not eq([@customer_6])

      end
   end

   describe "#invoices_with_items_ready_to_ship" do
      it 'returns packaged invoice items ordered by creation time desc' do

         expect(@green_merchant.invoices_with_items_ready_to_ship).to eq([@invoiceitem14, @invoiceitem7, @invoiceitem1])
      end
   end

   describe '.top_five_merchants' do
      it 'returns top five merchants by revenue' do
        top_merchants = Merchant.top_five_merchants

        expect(top_merchants.length).to eq(5)
        expect(top_merchants).to eq([@black_merchant, @green_merchant, @blue_merchant, @white_merchant, @brown_merchant])
      end
   end

   describe '#best_day' do
      it 'returns the day with the highest sales for the merchant' do

         expect(@green_merchant.best_day.to_date).to eq(@invoice4.created_at.to_date)
      end
   end
end

