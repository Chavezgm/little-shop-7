class MerchantInvoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :invoice


  def formatted_date
    created_at.strftime("%A, %B %d, %Y")
  end
end