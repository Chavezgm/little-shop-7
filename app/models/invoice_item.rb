class InvoiceItem < ApplicationRecord
   belongs_to :item
   belongs_to :invoice

   enum :status, ["pending", "packaged", "shipped"]

   def converted_unit_price 
      unit_price.to_f/100
   end

   def total_revenue
      total_rev = (unit_price.to_f/100) * quantity
      formatted_tot_rev = '%.2f' % total_rev
      formatted_tot_rev.to_f
   end
end