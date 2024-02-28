require "rails_helper"

RSpec.describe "Dashboard index" do
  before(:each) do
    
    # require 'pry'; binding.pry
    @green_merchant = Merchant.create!(name: "Green Inc")
    @black_merchant = Merchant.create!(name: "Black Inc")
    @brown_merchant = Merchant.create!(name: "Brown Inc")
    
    @item1 = FactoryBot.create(:item, name: "table", merchant_id: @green_merchant.id)
    @item2 = FactoryBot.create(:item, name: "pen", merchant_id: @green_merchant.id)
    @item3 = FactoryBot.create(:item, name: "paper", merchant_id: @green_merchant.id)

    @cust_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
    @cust_2 = create(:customer, first_name: "John", last_name: "Smith")
    @cust_3 = create(:customer, first_name: "Jane", last_name: "Perry") #cust_4 will have 15 successful transactions 
    @cust_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
    @cust_5 = create(:customer, first_name: "Patrick", last_name: "Karl")
    @cust_6 = Customer.create(first_name: "Palm", last_name: "Sir") #cust_6 will have 0  transactions 
    #each customer that is created will have 5 invoices with it plus the ones we created below for example cust_1 has 7 invoices
    #for each  invoice it will have 3 transactions
    # 5 * 3 = 15 transactions from factory when we create a customer
    #2 * 3 = 6 transaction for eac in voice that we created which was invoice6 and invoice1 
    @invoice1 = FactoryBot.create(:invoice, customer_id: @cust_6.id, status: 1, created_at: "Thu, 22 Feb 2024 22:05:45.453230000 UTC +00:00")
    #then created 2 extra transactions for customer 1 for each invoice that we made 
    # @invoice1 = FactoryBot.create(:invoice, customer_id: @cust_1.id, status: 1)  #cust1 = 21
    @invoice6 = FactoryBot.create(:invoice, customer_id: @cust_1.id, status: 1, created_at: "Mon, 19 Feb 2024 22:05:45.453230000 UTC +00:00")
    
    @invoice2 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 2)
    @invoice7 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 2)  #cust2 = 24
    @invoice8 = FactoryBot.create(:invoice, customer_id: @cust_2.id, status: 2)
    
    @invoice3 = FactoryBot.create(:invoice, customer_id: @cust_3.id, status: 1)  #cust_3 = 18
    
    @invoice4 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
    @invoice5 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
    @invoice9 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)  #cust_5 = 27
    @invoice10 = FactoryBot.create(:invoice, customer_id: @cust_5.id, status: 1)
    @transaction10 = FactoryBot.create(:transaction, invoice: @invoice10, result: 1)  #cust_5 = 27 successful transactions and 1 is unsuccessful so it should still give us 27 successful transactions 

    @invoice_item_1 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: "shipped") #5000
    @invoice_item_3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice6.id, quantity: 2, unit_price: 1000, status: "shipped") #2000
    @invoice_item_4 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: "packaged") #5000
    @invoice_item_5 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice6.id, quantity: 2, unit_price: 1000, status: "packaged") #2000
    @invoice_item_6 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice6.id, quantity: 2, unit_price: 1000, status: "packaged") #2000
  end 
  
  describe 'US1' do
    it 'shows the name of my merchant' do
      visit dashboard_merchant_path(@green_merchant)

      expect(page).to have_content(@green_merchant.name)
    end
  end

  describe 'US 2' do
    it ' link to my merchant items index' do
      visit dashboard_merchant_path(@green_merchant)

      expect(page).to have_link('My Items')

      click_link("My Items")

      expect(current_path).to eq(merchant_items_path(@green_merchant))
    end

    it 'link to my merchant invoices index ' do
      visit dashboard_merchant_path(@green_merchant)

      expect(page).to have_link('My Invoices')

      click_link("My Invoices")

      expect(current_path).to eq(merchant_invoices_path(@green_merchant))
    
    end
  end

  describe 'US 3' do
    it 'displays top 5 customers' do
      visit dashboard_merchant_path(@green_merchant)

      expect(page).to have_content("Top 5 Customers:")
  
      within "#customer_#{@cust_5.id}" do 
        expect(page).to have_content(@cust_5.first_name)
        # require 'pry' ; binding.pry
        expect(page).to have_content("Number of Successful Transactions: #{@cust_5.transactions.success.count}")
      end

      within "#customer_#{@cust_2.id}" do 
        expect(page).to have_content(@cust_2.first_name)
        expect(page).to have_content("Number of Successful Transactions: #{@cust_2.transactions.success.count}")
      end

      within "#customer_#{@cust_1.id}" do 
        expect(page).to have_content(@cust_1.first_name)
        expect(page).to have_content("Number of Successful Transactions: #{@cust_1.transactions.success.count}")
      end

      within "#customer_#{@cust_3.id}" do 
        expect(page).to have_content(@cust_3.first_name)
        expect(page).to have_content("Number of Successful Transactions: #{@cust_3.transactions.success.count}")
      end

      within "#customer_#{@cust_4.id}" do 
        expect(page).to have_content(@cust_4.first_name)
        expect(page).to have_content("Number of Successful Transactions: #{@cust_4.transactions.success.count}")
      end

      expect(page).to_not have_content(@cust_6.first_name)
    end
  end

  describe 'US 4' do
    it 'displays items ready to ship' do

      visit dashboard_merchant_path(@green_merchant.id)
      
      within ".items_ready_to_ship" do
        expect(page).to have_content("Unshipped Items")
        within "#invoice-item-#{@invoice_item_6.id}" do
          expect(page).to have_content(@item2.name)
          expect(page).not_to have_content(@item3.name)
          expect(page).to have_content(@invoice_item_6.invoice.created_at.strftime('%A, %B %d, %Y'))
        end
        
        within "#invoice-item-#{@invoice_item_5.id}" do
          expect(page).to have_content(@item1.name)
          expect(page).not_to have_content(@item2.name)
          expect(page).to have_content(@invoice_item_5.invoice.created_at.strftime('%A, %B %d, %Y'))
        end

        expect(page).to_not have_content(@item3.name)
        expect(page).to have_link("##{@invoice1.id}")
        # click_link("#{@invoice1.id}")
    end
    # expect(current_path).to eq(merchant_invoice_path(@green_merchant, @invoice6))
  end
end

  describe "US 5" do # Merchant Dashboard Invoices sorted by least recent
    it "it displays the created date for invoices and lists them oldest to newest" do 

      visit dashboard_merchant_path(@green_merchant.id)

      within '.items_ready_to_ship' do

        within "#invoice-item-#{@invoice_item_6.id}" do
        
          expect(page).to have_content(@item2.name)
          expect(page).not_to have_content(@item3.name)
          expect(page).to have_content(@invoice_item_6.invoice.created_at.strftime('%A, %B %d, %Y'))
        end
        
        within "#invoice-item-#{@invoice_item_5.id}" do
          expect(page).to have_content(@item1.name)
          expect(page).not_to have_content(@item2.name)
          expect(page).to have_content(@invoice_item_5.invoice.created_at.strftime('%A, %B %d, %Y'))
        end

        expect(@invoice_item_6.invoice.created_at.strftime('%A, %B %d, %Y')).to appear_before(@invoice_item_4.invoice.created_at.strftime('%A, %B %d, %Y'))
      end
    end
  end
end
  # describe "US 5" do
  #   it "displays id of the invoice that is ordered by its item" do
  #     visit dashboard_merchant_path(@green_merchant)

  #     within "#items_ready_to_ship" do
  #     expect(page).to have_content("Items Ready to Ship:")

  #       expect(page).to_not have_content(@item3.name)
      
  #       within "#invoice-#{@invoice1.id}" do
  #         expect(page).to have_content("Item: table")
  #         expect(page).to have_content("[date]}")
  #       end 

  #       within "#invoice-#{@invoice6.id}" do
  #         expect(page).to have_content("Item: pen")
  #         expect(page).to have_content("[date]}") 
  #         click_link "Invoice ##{@invoice6.id}"
  #       end 
  #     end
  #   end
  # end