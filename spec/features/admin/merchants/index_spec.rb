require 'rails_helper'

RSpec.describe 'Admin Merchants Index', type: :feature do
   describe 'as an admin' do
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
            
         @invoiceitem1 = InvoiceItem.create!(invoice: @invoice1, item: @item1, quantity: 5, unit_price: 1, status: 0 )
         # @invoiceitem2 = InvoiceItem.create!(invoice: @invoice1, item: @item2, quantity: 5, unit_price: 1, status: 0 )
         # @invoiceitem3 = InvoiceItem.create!(invoice: @invoice2, item: @item2, quantity: 5, unit_price: 1, status: 0 )
         @invoiceitem4 = InvoiceItem.create!(invoice: @invoice2, item: @item3, quantity: 6, unit_price: 1, status: 0 )
         # @invoiceitem5 = InvoiceItem.create!(invoice: @invoice3, item: @item2, quantity: 6, unit_price: 1, status: 0 )
         @invoiceitem6 = InvoiceItem.create!(invoice: @invoice3, item: @item3, quantity: 6, unit_price: 1, status: 0 )
         @invoiceitem7 = InvoiceItem.create!(invoice: @invoice4, item: @item1, quantity: 7, unit_price: 1, status: 0 )
         # @invoiceitem8 = InvoiceItem.create!(invoice: @invoice4, item: @item3, quantity: 10, unit_price: 1, status: 0 )
         @invoiceitem9 = InvoiceItem.create!(invoice: @invoice5, item: @item2, quantity: 10, unit_price: 1, status: 0 )
         # @invoiceitem10 = InvoiceItem.create!(invoice: @invoice5, item: @item3, quantity: 10, unit_price: 1, status: 0 )
         # @invoiceitem11 = InvoiceItem.create!(invoice: @invoice6, item: @item1, quantity: 8, unit_price: 1, status: 0 )
         @invoiceitem12 = InvoiceItem.create!(invoice: @invoice6, item: @item2, quantity: 8, unit_price: 1, status: 0 )
         # @invoiceitem13 = InvoiceItem.create!(invoice: @invoice7, item: @item3, quantity: 8, unit_price: 1, status: 0 )
         @invoiceitem14 = InvoiceItem.create!(invoice: @invoice7, item: @item4, quantity: 10, unit_price: 1, status: 0 )
         @invoiceitem15 = InvoiceItem.create!(invoice: @invoice8, item: @item5, quantity: 15, unit_price: 1, status: 0 )
         # @invoiceitem16 = InvoiceItem.create!(invoice: @invoice8, item: @item7, quantity: 13, unit_price: 1, status: 0 )
         @invoiceitem17 = InvoiceItem.create!(invoice: @invoice9, item: @item9, quantity: 17, unit_price: 1, status: 0 )
         # @invoiceitem18 = InvoiceItem.create!(invoice: @invoice9, item: @item11, quantity: 2, unit_price: 1, status: 0 )         
         @invoiceitem19 = InvoiceItem.create!(invoice: @invoice10, item: @item7, quantity: 13, unit_price: 1, status: 0 )
         # @invoiceitem20 = InvoiceItem.create!(invoice: @invoice10, item: @item9, quantity: 17, unit_price: 1, status: 0 )
      end

      # User Story 24
      it 'displays the name of each merchant' do
         visit admin_merchants_path

         expect(page).to have_content("Merchants")

         within "#merchant-#{@green_merchant.id}" do
            expect(page).to have_content(@green_merchant.name)
         end

         within "#merchant-#{@black_merchant.id}" do
            expect(page).to have_content(@black_merchant.name)
         end

         within "#merchant-#{@brown_merchant.id}" do
            expect(page).to have_content(@brown_merchant.name)
         end
      end
      # User Story 26
      it 'has a link for each merchant' do
         visit admin_merchants_path

         expect(page).to have_content("Merchants")

         within "#merchant-#{@green_merchant.id}" do
            expect(page).to have_link("#{@green_merchant.name}", href: admin_merchant_path(@green_merchant.id))

            click_on(@green_merchant.name)

            expect(current_path).to eq(admin_merchant_path(@green_merchant.id))
         end

         visit admin_merchants_path

         within "#merchant-#{@black_merchant.id}" do
            expect(page).to have_link("#{@black_merchant.name}", href: admin_merchant_path(@black_merchant.id))

            click_on(@black_merchant.name)

            expect(current_path).to eq(admin_merchant_path(@black_merchant.id))
         end

         visit admin_merchants_path

         within "#merchant-#{@brown_merchant.id}" do
            expect(page).to have_link("#{@brown_merchant.name}", href: admin_merchant_path(@brown_merchant.id))

            click_on(@brown_merchant.name)

            expect(current_path).to eq(admin_merchant_path(@brown_merchant.id))
         end
      end

      # User Story 27
      it 'can enable or disable a merchant from the admin merchants index' do
         visit admin_merchants_path

         within "#merchant-#{@green_merchant.id}" do
            expect(page).to have_button("Change Status") 
            expect(page).to have_content("Enabled")
         end
         expect(current_path).to eq(admin_merchants_path)

         within "#merchant-#{@black_merchant.id}" do
            expect(page).to have_button("Change Status") 
            expect(page).to have_content("Disabled")
         end
         expect(current_path).to eq(admin_merchants_path)

         within "#merchant-#{@brown_merchant.id}" do
            expect(page).to have_button("Change Status") 
            expect(page).to have_content("Enabled")
         end
         expect(current_path).to eq(admin_merchants_path)
      end
      
      # User Story 28 
      it 'groups merchants by status' do 
         visit admin_merchants_path

         expect(page).to have_content("Enabled Merchants")
         expect(page).to have_content("Disabled Merchants")

         within "#enabled_merchants" do 
            expect(page).to have_content(@green_merchant.name)
            expect(page).to have_content(@brown_merchant.name)
         end

         within "#disabled_merchants" do 
            expect(page).to have_content(@black_merchant.name)
         end
      end

      # User Story 29 
      it 'shows a link to create new merchant' do
         visit admin_merchants_path

         expect(page).to have_link("Create New Merchant", href: new_admin_merchant_path)

         click_on("Create New Merchant")

         expect(current_path).to eq(new_admin_merchant_path)

         fill_in("merchant[name]" , with: "Nimo")

         click_on("Submit")

         expect(current_path).to eq(admin_merchants_path)
      end

      it 'will display a error if no name when updating' do
         visit new_admin_merchant_path

         fill_in("merchant[name]" , with: " ")

         click_on("Submit")

         expect(current_path).to eq(new_admin_merchant_path)
         expect(page).to have_content("Error:")
      end

      # User Story 30 
      it "displays a top 5 merchant section, with names of the merchants as links to their show page, and also shows the total revenue generated next to its name" do
         visit admin_merchants_path
   
         expect(page).to have_content("Top 5 Merchants by Revenue")
         expect(@black_merchant.name).to appear_before(@green_merchant.name) # $66.00
         expect(@green_merchant.name).to appear_before(@blue_merchant.name) # $44.00
         expect(@blue_merchant.name).to appear_before(@white_merchant.name) # $34.00
         expect(@white_merchant.name).to appear_before(@brown_merchant.name) # $26.00 / $24.00

    
      end

      # User Story 31 
      it "displays the date of the top 5 merchants most profitable days" do 
         visit admin_merchants_path

         within ".top_merchants" do

         expect(page).to have_content(@green_merchant.name)
         expect(page).to have_content(@green_merchant.best_day.strftime("%B %d, %Y"))
         
         expect(page).to have_content(@black_merchant.name)
         expect(page).to have_content(@black_merchant.best_day.strftime("%B %d, %Y"))

         expect(page).to have_content(@brown_merchant.name)
         expect(page).to have_content(@brown_merchant.best_day.strftime("%B %d, %Y"))

         expect(page).to have_content(@blue_merchant.name)
         expect(page).to have_content(@blue_merchant.best_day.strftime("%B %d, %Y"))

         expect(page).to have_content(@white_merchant.name)
         expect(page).to have_content(@white_merchant.best_day.strftime("%B %d, %Y"))
         
         end
      end
   
   end
end