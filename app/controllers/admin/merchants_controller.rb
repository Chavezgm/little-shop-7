class Admin::MerchantsController < ApplicationController
   def index
      # binding.pry
      @merchants = Merchant.all
      @enabled_merchants = Merchant.where(status: :enabled)
      @disabled_merchants = Merchant.where(status: :disabled)
      @merchants = Merchant.top_five_merchants
   end

   def show
      @merchant = Merchant.find(params[:id])
   end

   def edit
      @merchant = Merchant.find(params[:id])
   end

   def update
      @merchant = Merchant.find(params[:id])
      
      if params[:update_status] == "disable"
         @merchant.update!(status: :disabled)
         redirect_to admin_merchants_path

      elsif @merchant.update(merchant_params)
         redirect_to admin_merchant_path(@merchant.id)
         flash[:alert] = "Merchant Successfully Updated"
      else
         flash[:alert] = "Error: #{error_message(@merchant.errors)}"
         redirect_to edit_admin_merchant_path(@merchant.id)
      end
     
   
   end


   def new
      @merchant = Merchant.new
   end
    
   def create
      
      @merchant = Merchant.new(merchant_params)

      if @merchant.save
         redirect_to admin_merchants_path
         flash[:alert] = "Merchant Successfully Created"
      else
         flash[:alert] = "Error: #{error_message(@merchant.errors)}"
         redirect_to new_admin_merchant_path(@merchant.id)
      end
      
   end

   private
   def merchant_params
      params.require(:merchant).permit(:name, :status)
   end
end