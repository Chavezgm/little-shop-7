require 'rails_helper'

RSpec.describe 'Merchant_invoices Index Page', type: :feature do
  describe 'merch_invoices index' do
    it 'displays merchants invoices with a link to show page' do
      @green_merchant = Merchant.create!(name: "Green Inc")

      @item1 = Item.create!(name: "table", description: "it's a table", unit_price: 2546, merchant_id: @green_merchant.id)
      @item2 = Item.create!(name: "pen", description: "it's a pen", unit_price: 5367, merchant_id: @green_merchant.id)
      @item3 = Item.create!(name: "paper", description: "it's paper", unit_price: 8767, merchant_id: @green_merchant.id)

      @cust_1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")

      @invoice1 = Invoice.create!(customer_id: @cust_1.id, status: 1)
      @invoice2 = Invoice.create!(customer_id: @cust_1.id, status: 1)

      @invoice_item_1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: "shipped") #5000
      @invoice_item_3 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 1000, status: "shipped") #2000
      @invoice_item_4 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: "packaged") #5000
      
      # When I visit my merchant's invoices index (/merchants/:merchant_id/invoices)
      visit merchant_invoices_path(@green_merchant)
      
      # Then I see all of the invoices that include at least one of my merchant's items
      # And for each invoice I see its id
      # And each id links to the merchant invoice show page
      within "#merchant_name" do
        expect(page).to have_content("#{@green_merchant.name} Invoices")
      end

      within "#merchant_invoices" do
        expect(page).to have_link("#{@invoice1.id}")
        expect(page).to have_link("#{@invoice2.id}")
      end
    end
  end
end
