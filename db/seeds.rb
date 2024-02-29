# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# cust_1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
# cust_2 = Customer.create!(first_name: "John", last_name: "Smith")
# cust_3 = Customer.create!(first_name: "Jane", last_name: "Perry")
# cust_4 = Customer.create!(first_name: "Buzz", last_name: "Lightyeay")
# cust_5 = Customer.create!(first_name: "Patrick", last_name: "Karl")
# cust_6 = Customer.create!(first_name: "Igor", last_name: "Mag")
# cust_7 = Customer.create!(first_name: "Selena", last_name: "Has")
# cust_8 = Customer.create!(first_name: "Martin", last_name: "Des")
# cust_9 = Customer.create!(first_name: "Carl", last_name: "Johnson")
# cust_10 = Customer.create!(first_name: "Peter", last_name: "Petigurew")

# inv_1 = Invoice.create!(status: )

# Create customers
customer1 = Customer.create(first_name: "John", last_name: "Doe")
customer2 = Customer.create(first_name: "Jane", last_name: "Smith")
customer3 = Customer.create(first_name: "Michael", last_name: "Johnson")
customer4 = Customer.create(first_name: "Emily", last_name: "Brown")
customer5 = Customer.create(first_name: "William", last_name: "Jones")

# Create merchants
merchant1 = Merchant.create(name: "Merchant 1")
merchant2 = Merchant.create(name: "Merchant 2")

# Create items
item1 = Item.create(name: "Item 1", description: "Description for Item 1", unit_price: 100, merchant: merchant1)
item2 = Item.create(name: "Item 2", description: "Description for Item 2", unit_price: 200, merchant: merchant1)
item3 = Item.create(name: "Item 3", description: "Description for Item 3", unit_price: 150, merchant: merchant1, status: 1 )
item4 = Item.create(name: "Item 4", description: "Description for Item 4", unit_price: 180, merchant: merchant1, status: 1 )
item5 = Item.create(name: "Item 5", description: "Description for Item 5", unit_price: 120, merchant: merchant2)

# Create invoices
invoice1 = Invoice.create(status: 0, customer: customer1)
invoice2 = Invoice.create(status: 0, customer: customer2)
invoice3 = Invoice.create(status: 1, customer: customer3)
invoice4 = Invoice.create(status: 1, customer: customer4)
invoice5 = Invoice.create(status: 0, customer: customer5)

# Create invoice items
InvoiceItem.create(item: item1, invoice: invoice1, quantity: 5, unit_price: 100) # Adjust quantity for top items
InvoiceItem.create(item: item2, invoice: invoice2, quantity: 4, unit_price: 200)
InvoiceItem.create(item: item3, invoice: invoice3, quantity: 3, unit_price: 150)
InvoiceItem.create(item: item4, invoice: invoice4, quantity: 2, unit_price: 180)
InvoiceItem.create(item: item5, invoice: invoice5, quantity: 1, unit_price: 120)

# Create transactions
Transaction.create(invoice: invoice1, credit_card_number: "1234567890123456", credit_card_expiration_date: "12/25", result: 0)
Transaction.create(invoice: invoice2, credit_card_number: "9876543210987654", credit_card_expiration_date: "01/30", result: 1)
Transaction.create(invoice: invoice3, credit_card_number: "5555666677778888", credit_card_expiration_date: "06/28", result: 0)
Transaction.create(invoice: invoice4, credit_card_number: "9999888877776666", credit_card_expiration_date: "09/24", result: 1)
Transaction.create(invoice: invoice5, credit_card_number: "4444333322221111", credit_card_expiration_date: "03/27", result: 0)