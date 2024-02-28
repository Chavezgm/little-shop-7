require 'rails_helper'

RSpec.describe Item, type: :model do
   describe 'relationships' do
      it { should belong_to :merchant }
      it { should have_many :invoice_items }
      it { should have_many(:invoices).through(:invoice_items) }
   end

   describe 'enabled_item' do
     it 'returns only enabled items' do
         @merchant1 = Merchant.create!(name: "Merchant A")
         @merchant2 = Merchant.create!(name: "Merchant B")
   
         @item1 = Item.create!(name: "Gum", description: "Description for Item 1", unit_price: 1000, merchant: @merchant1)
         @item2 = Item.create!(name: "Mint", description: "Description for Item 2", unit_price: 2000, merchant: @merchant1)
         @item3 = Item.create!(name: "Apple", description: "Description for Item 3", unit_price: 3000, merchant: @merchant2, status: 1)
         @item4 = Item.create!(name: "Orange", description: "Description for Item 4", unit_price: 4000, merchant: @merchant2, status: 1)
         
  
       expect(Item.enabled_items).to eq([@item1,@item2])
       expect(Item.enabled_items).to_not eq([@item3,@item4])
     end
   end

  describe 'disabled_items' do
    it 'returns only enabled items' do
      @merchant1 = Merchant.create!(name: "Merchant A")
      @merchant2 = Merchant.create!(name: "Merchant B")

      @item1 = Item.create!(name: "Gum", description: "Description for Item 1", unit_price: 1000, merchant: @merchant1)
      @item2 = Item.create!(name: "Mint", description: "Description for Item 2", unit_price: 2000, merchant: @merchant1)
      @item3 = Item.create!(name: "Apple", description: "Description for Item 3", unit_price: 3000, merchant: @merchant2, status: 1)
      @item4 = Item.create!(name: "Orange", description: "Description for Item 4", unit_price: 4000, merchant: @merchant2, status: 1)
      

      expect(Item.disabled_items).to eq([@item3,@item4])
      expect(Item.disabled_items).to_not eq([@item1,@item2])
    end
  end

  describe '.top_5_items' do
    it 'returns top 5' do
      @customer1 = Customer.create(first_name: "Martin", last_name: "Chavez")
      @customer2 = Customer.create(first_name: "Rodrigo", last_name: "Alberto")

      
      @merchant1 = Merchant.create(name: "Merchant A")
      @merchant2 = Merchant.create(name: "Merchant B")

      
      @item1 = Item.create(name: "Gum", description: "Description for Item 1", unit_price: 1000, merchant: @merchant1)
      @item2 = Item.create(name: "Mint", description: "Description for Item 2", unit_price: 2000, merchant: @merchant1)
      @item3 = Item.create(name: "Apple", description: "Description for Item 3", unit_price: 3000, merchant: @merchant2)
      @item4 = Item.create(name: "Ball", description: "Description for ball", unit_price: 1000, merchant: @merchant1)
      @item5 = Item.create(name: "Bat", description: "Description for bat", unit_price: 5000, merchant: @merchant1)
      @item6 = Item.create(name: "Glove", description: "Description for glove", unit_price: 1000, merchant: @merchant1)
      @item7 = Item.create(name: "Football", description: "Description for football", unit_price: 2000, merchant: @merchant1)
      @item8 = Item.create(name: "Desk", description: "Description for desk", unit_price: 3000, merchant: @merchant1)

    
      @invoice1 = Invoice.create(status: 1, customer: @customer1)
      # @invoice2 = Invoice.create(status: 1, customer: @customer2)

      @invoice_item3 = InvoiceItem.create(item: @item3, invoice: @invoice1, quantity: 4, unit_price: 4000, status: 1) #16,000

      @invoice_item6 = InvoiceItem.create(item: @item6, invoice: @invoice1, quantity: 4, unit_price: 5000, status: 1) #200.00 #Glove
      @invoice_item5 = InvoiceItem.create(item: @item5, invoice: @invoice1, quantity: 4, unit_price: 4000, status: 1) #160.00 #Bat
      @invoice_item2 = InvoiceItem.create(item: @item2, invoice: @invoice1, quantity: 3, unit_price: 4000, status: 1) #120.00 #Mint
      @invoice_item4 = InvoiceItem.create(item: @item4, invoice: @invoice1, quantity: 5, unit_price: 2000, status: 1) #100.00 #Ball
      @invoice_item8 = InvoiceItem.create(item: @item8, invoice: @invoice1, quantity: 2, unit_price: 4000, status: 1) #80.00 #Desk
      @invoice_item7 = InvoiceItem.create(item: @item7, invoice: @invoice1, quantity: 1, unit_price: 4000, status: 1) #40.00 #Football
      @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 2, unit_price: 1000, status: 1) #20.00 #Gum

      @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: "1234567890123456", credit_card_expiration_date: "12/23", result: 0)
      # @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: "9876543210987654", credit_card_expiration_date: "09/24", result: 1)
      top = Item.top_5_items
      expect(top).to eq([@item6, @item3, @item5, @item2,@item4])
      expect(top.first.total_rev).to eq(200)
      expect(top[1].total_rev).to eq(160)
      expect(top[2].total_rev).to eq(160)
      expect(top[3].total_rev).to eq(120)
      expect(top[4].total_rev).to eq(100)
     
      # expect(@item6.best_day).to eq("11/30/20")
    end
  end

  describe '#best_day' do
    it 'returns the best date an item had' do
      @customer1 = Customer.create(first_name: "Martin", last_name: "Chavez")
      # @customer2 = Customer.create(first_name: "Rodrigo", last_name: "Alberto")

      
      @merchant1 = Merchant.create(name: "Merchant A")
      # @merchant2 = Merchant.create(name: "Merchant B")

      
      @item1 = Item.create(name: "Gum", description: "Description for Item 1", unit_price: 1000, merchant: @merchant1)
      @item2 = Item.create(name: "Mint", description: "Description for Item 2", unit_price: 2000, merchant: @merchant1)
      # @item3 = Item.create(name: "Apple", description: "Description for Item 3", unit_price: 3000, merchant: @merchant2)
      @item4 = Item.create(name: "Ball", description: "Description for ball", unit_price: 1000, merchant: @merchant1)
      @item5 = Item.create(name: "Bat", description: "Description for bat", unit_price: 5000, merchant: @merchant1)
      @item6 = Item.create(name: "Glove", description: "Description for glove", unit_price: 1000, merchant: @merchant1)
      @item7 = Item.create(name: "Football", description: "Description for football", unit_price: 2000, merchant: @merchant1)
      @item8 = Item.create(name: "Desk", description: "Description for desk", unit_price: 3000, merchant: @merchant1)

      
      @invoice1 = Invoice.create(status: 1, customer: @customer1, created_at: "Thu, 22 Feb 2024 22:05:45.453230000 UTC +00:00")
      @invoice2 = Invoice.create(status: 1, customer: @customer1, created_at: "Mon, 19 Feb 2024 22:05:45.453230000 UTC +00:00")
      @invoice3 = Invoice.create(status: 1, customer: @customer1, created_at: "Mon, 24 Feb 2024 22:05:45.453230000 UTC +00:00")

      # @invoice2 = Invoice.create(status: 1, customer: @customer2)

      @invoice_item3 = InvoiceItem.create(item: @item3, invoice: @invoice1, quantity: 4, unit_price: 4000, status: 1) #16,000

      @invoice_item6 = InvoiceItem.create(item: @item6, invoice: @invoice1, quantity: 4, unit_price: 5588, status: 1) #22352 #Glove
      @invoice_item6 = InvoiceItem.create(item: @item6, invoice: @invoice2, quantity: 2, unit_price: 5588, status: 1) #22352 #Glove
      @invoice_item5 = InvoiceItem.create(item: @item5, invoice: @invoice1, quantity: 4, unit_price: 4000, status: 1) #160.00 #Bat
      @invoice_item5 = InvoiceItem.create(item: @item5, invoice: @invoice3, quantity: 2, unit_price: 4000, status: 1) #160.00 #Bat
      @invoice_item2 = InvoiceItem.create(item: @item2, invoice: @invoice2, quantity: 3, unit_price: 4000, status: 1) #120.00 #Mint
      @invoice_item2 = InvoiceItem.create(item: @item2, invoice: @invoice1, quantity: 1, unit_price: 4000, status: 1) #120.00 #Mint
      @invoice_item4 = InvoiceItem.create(item: @item4, invoice: @invoice2, quantity: 5, unit_price: 2000, status: 1) #100.00 #Ball
      @invoice_item4 = InvoiceItem.create(item: @item4, invoice: @invoice1, quantity: 2, unit_price: 2000, status: 1) #100.00 #Ball
      @invoice_item8 = InvoiceItem.create(item: @item8, invoice: @invoice1, quantity: 2, unit_price: 4000, status: 1) #80.00 #Desk
      @invoice_item8 = InvoiceItem.create(item: @item8, invoice: @invoice2, quantity: 3, unit_price: 4000, status: 1) #80.00 #Desk
      @invoice_item7 = InvoiceItem.create(item: @item7, invoice: @invoice1, quantity: 1, unit_price: 4000, status: 1) #40.00 #Football
      @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 2, unit_price: 1000, status: 1) #20.00 #Gum
      


      @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: "1234567890123456", credit_card_expiration_date: "12/23", result: 0)
      @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: "12345678888888", credit_card_expiration_date: "12/23", result: 0)
      @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: "1234567890123456", credit_card_expiration_date: "12/23", result: 1)
      # @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: "9876543210987654", credit_card_expiration_date: "09/24", result: 1)
      # require 'pry'; binding.pry
      expect(@item6.best_day.strftime('%A, %B %d, %Y')).to eq("Thursday, February 22, 2024")

    end
  end

end