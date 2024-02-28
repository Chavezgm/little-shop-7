class ItemsController < ApplicationController

  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show 
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit 
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
    @item.update(item_params)

    if !params[:status]

      redirect_to(merchant_item_path(@merchant, @item))

      flash[:alert] = "Item information successfully updated!!"

    else 

      redirect_to(merchant_items_path(@merchant))

    end
  end

  def create 
    @merchant = Merchant.find(params[:merchant_id])
    item = @merchant.items.new(item_params)
    item.status = "disabled"
  
    if item.save
      flash[:alert] = "Item created!!"
      redirect_to merchant_items_path(@merchant)
    else 
      render :new
    end

  end

  
  private 

  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end

end


# else 
#   redirect_to edit_merchant_item_path(@merchant, @item)
#   flash[:alert] = "Item information NOT successfully updated"


# if @item.update(item_params)
#   # redirect_to merchant_item_path(@merchant, @item)
#   flash[:alert] = "Item information successfully updated!!"
#   redirect_to(merchant_item_path(@merchant, @item))

# elsif params[:status].present? && params[:status] == 'disabled'
#   @item.update(status: 1)
#   redirect_to(merchant_items_path(@merchant))
# elsif params[:status].present? && params[:status] == 'enabled'
#   @item.update(status: 0)
#   redirect_to(merchant_items_path(@merchant))
# end