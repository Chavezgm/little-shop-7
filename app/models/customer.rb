class Customer < ApplicationRecord
   has_many :invoices, dependent: :destroy
   has_many :items, through: :invoices
   has_many :transactions, through: :invoices
   
   def self.top_five_customers
      Customer.select("customers.*, count(transactions.id) as count_transactions")
      .joins(:transactions).where(transactions: {result: "success"})
      .group('customers.id')
      .order("count_transactions DESC")
      .limit(5)
   end

   def successful_trans_count
      transactions.success.count
   end

   def self.top_five_customers
      Customer.select("customers.*, count(transactions.result = 0) as count_transactions").joins(:transactions).group('customers.id').order("count_transactions DESC").limit(5)
   end

   def successful_transactions_count
      self.transactions.count("transactions.result = 0")
   end
end