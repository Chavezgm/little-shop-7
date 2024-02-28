class Merchant < ApplicationRecord
   has_many :items, dependent: :destroy
   has_many :invoice_items, through: :items
   has_many :invoices, through: :invoice_items
   has_many :customers, through: :invoices
   
   validates :name, presence: true
   enum :status, [ "enabled", "disabled"]

   def top_five_customers
      Customer.select("customers.*, count(transactions.id) as count_transactions")
         .joins(:transactions).where(transactions: {result: "success"})
         .group('customers.id')
         .order("count_transactions DESC")
         .limit(5)
   end

   def invoices_with_items_ready_to_ship
      invoice_items.packaged.order("created_at desc")
   end

   def self.top_five_merchants
      select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(invoices: [:transactions, :invoice_items]).where(transactions: { result: "success" })
      .group("merchants.id")
      .order("revenue DESC")
      .limit(5)
   end

   def best_day
      invoices.joins(:items)
      .group("invoices.created_at")
      .sum("invoice_items.quantity * items.unit_price")
      .max_by { |date, sales| sales }
      .first
   end
end
