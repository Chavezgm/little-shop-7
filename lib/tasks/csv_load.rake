require "csv"

namespace :csv_load do

  desc "loads customer data"
  task customers: :environment do
    CSV.foreach("db/data/customers.csv", headers: true) do |row|
      Customer.create!(row.to_hash)
      reset_pk("customers")
    end 
  end

  desc "loads invoice_items data"
  task invoice_items: :environment do
    CSV.foreach("db/data/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
      reset_pk("invoice_items")
    end 
  end
 
  desc "loads invoices data"
  task invoices: :environment do
    CSV.foreach("db/data/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_hash)
      reset_pk("invoices")
    end 
  end

  desc "loads items data"
  task items: :environment do
    CSV.foreach("db/data/items.csv", headers: true) do |row|
      Item.create!(row.to_hash)
      reset_pk("items")
    end 
  end

  desc "loads merchant data"
  task merchants: :environment do
    CSV.foreach("db/data/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_hash)
      reset_pk("merchants")
    end 
  end

  desc "loads transaction data"
  task transactions: :environment do
    CSV.foreach("db/data/transactions.csv", headers: true) do |row|
      Transaction.create!(row.to_hash)
      reset_pk("transactions")
    end 

  end

  desc "loads all data"
  task all: :environment do
    CSV.foreach("db/data/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_hash)
      reset_pk("merchants")
    end 

    CSV.foreach("db/data/items.csv", headers: true) do |row|
      Item.create!(row.to_hash)
      reset_pk("items")
    end 

    CSV.foreach("db/data/customers.csv", headers: true) do |row|
      Customer.create!(row.to_hash)
      reset_pk("customers")
    end 

    CSV.foreach("db/data/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_hash)
      reset_pk("invoices")
    end 
    
    CSV.foreach("db/data/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
      reset_pk("invoice_items")
    end 

    CSV.foreach("db/data/transactions.csv", headers: true) do |row|
      Transaction.create!(row.to_hash)
      reset_pk("transactions")
    end 
  end
end

def reset_pk(table_name)
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
end