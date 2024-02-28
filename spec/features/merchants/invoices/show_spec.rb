require 'rails_helper'

RSpec.describe 'Merchant_invoices Show Page', type: :feature do
  describe 'merch_invoices show' do
    it 'displays invoice id, status, created_at, customer name to show page' do
      @green_merchant = Merchant.create!(name: "Green Inc")

      @item1 = Item.create!(name: "table", description: "it's a table", unit_price: 2546, merchant_id: @green_merchant.id)
      @item2 = Item.create!(name: "pen", description: "it's a pen", unit_price: 5367, merchant_id: @green_merchant.id)
      @item3 = Item.create!(name: "paper", description: "it's paper", unit_price: 8767, merchant_id: @green_merchant.id)

      @cust_1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")

      @invoice1 = Invoice.create!(customer_id: @cust_1.id, status: 1)

      @invoice_item_1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: "shipped") #5000
      @invoice_item_3 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 1000, status: "shipped") #2000
      @invoice_item_4 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: "packaged") #5000
#       When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    visit merchant_invoice_path(@green_merchant, @invoice1)
        expect(page).to have_content("Invoice #{@invoice1.id}")
        expect(page).to have_content("Status: completed")
        expect(page).to have_content("Created on: Wednesday, February 28, 2024") #"Created on: Wednesday, February 28, 2024"        #{@invoice1.created_at.strftime("%A, %B %d, %Y")}
        expect(page).to have_content("Joey Ondricka")
        save_and_open_page
    end
  end
end
# Then I see information related to that invoice including:
# - Invoice id
# - Invoice status
# - Invoice created_at date in the format "Monday, July 18, 2019"
# - Customer first and last name
