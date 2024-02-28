require 'rails_helper'

RSpec.describe 'Admin Invoice Show', type: :feature do
   describe 'as an admin' do
      before(:each) do
         @customer_1 = create(:customer, first_name: "Joey", last_name: "Ondricka")
         @customer_2 = create(:customer, first_name: "John", last_name: "Smith")
         @customer_3 = create(:customer, first_name: "Jane", last_name: "Perry")
         @customer_4 = create(:customer, first_name: "Buzz", last_name: "Lightyeay")
         @customer_5 = create(:customer, first_name: "Patrick", last_name: "Karl")

         @green_merchant = Merchant.create!(name: "Green Inc")
         @black_merchant = Merchant.create!(name: "Black Inc")
         @brown_merchant = Merchant.create!(name: "Brown Inc")
         
         item1 = create(:item, name: "table", merchant: @green_merchant)
         item2 = create(:item, name: "pen", merchant: @black_merchant)
         item3 = create(:item, name: "paper", merchant: @brown_merchant)
         
         @invoice1 = create(:invoice, customer_id: @customer_1.id, status: 0)
         
         @invoice2 = create(:invoice, customer_id: @customer_2.id, status: 0)
         
         @invoice3 = create(:invoice, customer_id: @customer_3.id, status: 0)
         
         @invoice_item_1 = create(:invoice_item, invoice: @invoice1)
         @invoice_item_2 = create(:invoice_item, invoice: @invoice2)
         @invoice_item_3 = create(:invoice_item, invoice: @invoice3)
      end

      # User Story 33
      it 'display all the information regarding the invoice' do
         visit admin_invoice_path(@invoice1.id)
         
         within "#invoice_attributes" do
            expect(page).to have_content(@invoice1.status)
            expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %e, %Y"))
            expect(page).to have_content(@invoice1.customer.first_name)
            expect(page).to have_content(@invoice1.customer.last_name)
         end
      end

      # User Story 34
      it 'displays the Invoice Item Information to that Invoice' do
         visit admin_invoice_path(@invoice1.id)
        
         within "#invoice_items" do
            expect(page).to have_content("Invoice Items")

            within "#invoice_item_#{@invoice_item_1.id}" do
               expect(page).to have_content(@invoice_item_1.item.name)
               expect(page).to have_content(@invoice_item_1.quantity)
               expect(page).to have_content("Unit Price: $#{@invoice_item_1.converted_unit_price}")
               expect(page).to have_content(@invoice_item_1.status.capitalize)
            end
         end
      end

      # User Story 35
      it 'displays the total revenue that will generate this invoice' do
         visit admin_invoice_path(@invoice1.id)

         expect(page).to have_content(@invoice_item_1.total_revenue.round(2))
      end

      # User Story 36
      it 'display the invoice status as a select field and the current status is selected' do
         visit admin_invoice_path(@invoice1.id)
         
         within "#status-selector" do
         expect(page).to have_content('Status')
         expect(page).to have_content("in progress")

         select("completed", from: "invoice[status]")
         click_on "Update Invoice Status"
         end

         expect(current_path).to eq(admin_invoice_path(@invoice1.id))
         expect(page).to have_content("completed")
      end
   end
end