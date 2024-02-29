require 'rails_helper'

RSpec.describe 'Merchant_invoices Show Page', type: :feature do
  before do 
    @green_merchant = Merchant.create!(name: "Green Inc")
    @black_merchant = Merchant.create!(name: "Black Inc")
    
    @item1 = Item.create!(name: "table", description: "it's a table", unit_price: 2546, merchant_id: @green_merchant.id)
    @item2 = Item.create!(name: "pen", description: "it's a pen", unit_price: 5367, merchant_id: @green_merchant.id)
    @item3 = Item.create!(name: "paper", description: "it's paper", unit_price: 8767, merchant_id: @green_merchant.id)
    @item4 = Item.create!(name: "paper", description: "it's paper", unit_price: 8767, merchant_id: @black_merchant.id)
    
    @cust_1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
    
    @invoice1 = Invoice.create!(customer_id: @cust_1.id, status: 1)
    
    @invoice_item_1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 2546, status: "shipped") #5000
    @invoice_item_3 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 5367, status: "shipped") #2000
    @invoice_item_4 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 8767, status: "packaged") #5000
    @invoice_item_5 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 8767, status: "packaged") #5000|
  end

  describe 'merch_invoices show' do
    # User Story 15
    it 'displays invoice id, status, created_at, customer name to show page' do
      visit merchant_invoice_path(@green_merchant, @invoice1)

      expect(page).to have_content("Invoice #{@invoice1.id}")
      expect(page).to have_content("Status: completed")
      expect(page).to have_content("Created on: Wednesday, February 28, 2024") 
      expect(page).to have_content("Joey Ondricka")
    end
    
    # User Story 16
    it "lists all items on the invoice" do
      visit merchant_invoice_path(@green_merchant, @invoice1)
      
      within"#invoice_item-#{@invoice_item_1.id}" do
        expect(page).to have_content(@invoice_item_1.item.name)
        expect(page).to have_content(@invoice_item_1.quantity)
        expect(page).to have_content("Unit Price: $#{@invoice_item_1.converted_unit_price}")
        expect(page).to have_content(@invoice_item_1.status)
      end
      
      within"#invoice_item-#{@invoice_item_3.id}" do
        expect(page).to have_content(@invoice_item_3.item.name)
        expect(page).to have_content(@invoice_item_3.quantity)
        expect(page).to have_content("Unit Price: $#{@invoice_item_3.converted_unit_price}")
        expect(page).to have_content(@invoice_item_3.status)
      end

      within"#invoice_item-#{@invoice_item_4.id}" do
        expect(page).to have_content(@invoice_item_4.item.name)
        expect(page).to have_content(@invoice_item_4.quantity)
        expect(page).to have_content("Unit Price: $#{@invoice_item_4.converted_unit_price}")
        expect(page).to have_content(@invoice_item_4.status)
      end

      expect(page).not_to have_content(@invoice_item_5.id)
    end

    # User Story 16
    it "Displays total revenue from all items on invoice" do
      visit merchant_invoice_path(@green_merchant, @invoice1)
      expect(page).to have_content(@invoice_item_1.total_revenue)
    end
  end
end
