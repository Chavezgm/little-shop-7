require "rails_helper"

RSpec.describe "Items show" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Merchant A")
    @merchant2 = Merchant.create!(name: "Merchant B")

    @item1 = Item.create!(name: "Gum", description: "Description for Item 1", unit_price: 1000, merchant: @merchant1)
    @item2 = Item.create!(name: "Mint", description: "Description for Item 2", unit_price: 2000, merchant: @merchant1)
    @item3 = Item.create!(name: "Apple", description: "Description for Item 3", unit_price: 3000, merchant: @merchant2)
    @item4 = Item.create!(name: "Orange", description: "Description for Item 4", unit_price: 4000, merchant: @merchant2)

    @customer = Customer.create!(first_name: "John", last_name: "Doe")
    @invoice = Invoice.create!(status: "completed", customer: @customer)
    @invoice_item = InvoiceItem.create!(item: @item1, invoice: @invoice, quantity: 1, unit_price: 1000, status: "shipped")
    @transaction = Transaction.create!(invoice: @invoice, credit_card_number: "1234567890123456", credit_card_expiration_date: "12/23", result: "success")
  end

  

  describe 'US 8' do
    it 'Updates a Merchant Item' do
      visit merchant_item_path(@merchant1,@item1)
      # When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)
      
      expect(page).to have_link("Edit #{@item1.name}")
      # I see a link to update the item information.

      click_link("Edit #{@item1.name}")
      # When I click the link

      expect(current_path).to eq(edit_merchant_item_path(@merchant1,@item1))
      # Then I am taken to a page to edit this item

      fill_in :name, with: "Updated name"
      fill_in :description, with: "Updated description"
      fill_in :unit_price, with: 2500
      # And I see a form filled in with the existing item attribute information

      click_button('Submit')
      # When I update the information in the form and I click ‘submit’

      expect(page).to have_current_path(merchant_item_path(@merchant1, @item1))
      # Then I am redirected back to the item show page where I see the updated information
      expect(page).to have_content('Updated name')
      expect(page).to have_content('Updated description')
      # save_and_open_page
      expect(page).to have_content(2500)
      # And I see a flash message stating that the information has been successfully updated.

      expect(page).to have_content('Item information successfully updated')

      #NEED TO ASK QUESTION FOR THIS UPDATE ACTION!!!! 
    end
  end
end