require './lib/model_helper.rb'

class HomeController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :create_shop_obj
  def show
    puts params
    
  end
  def json_file
    puts 'json file'
  end
 

  def index
    puts params
    
    #gecko.access_token = access_token
  end

  def order_finalized
    render :json=> (mapping_model(gecko_params))
  end
  def order_fulfilled
   
    render :json=> (mapping_model(gecko_params))
  end
  def show_all_webhooks
    puts(@gecko.Webhook.where(status:'active'))
    render :json=> (@gecko.Webhook.where(status:'active').to_s)
  end
  

  def create_order
    render :json=> (mapping_model(gecko_params))
  end


  def update_order
    puts params
  
  end


  private 
  def create_shop_obj
    @gecko = Gecko::Client.new(ENV['OAUTH_ID'],ENV['OAUTH_SECRET'] )
    access_token = OAuth2::AccessToken.new(@gecko.oauth_client, ENV['ACCESS_TOKEN'])
    @gecko.access_token = access_token
  end

  def mapping_model(gecko_params)
  
    order_new=false
    common=ModelHelper.new
    order_main=@gecko.Order.find(gecko_params[:object_id])
    if order_main[:order_number].match(/SO/).present?
    user=@gecko.User.find(order_main[:user_id])
    order_model=Order.find_by(order_id:order_main[:id])
    billing=@gecko.Address.find(order_main[:billing_address_id])
    shipping=@gecko.Address.find(order_main[:shipping_address_id])
        user_model=common.user_method(user)
        bill_address_model= common.address_method(billing)
        ship_address_model= common.address_method(shipping)
   unless order_model.present?
    order_model=common.order_method(order_main)
    order_new=true
   end

   line_item=[]
   order_main[:order_line_item_ids].each do |item|
    line_item.push(common.line_item_method(@gecko.OrderLineItem.find(item)))
   end
   
  
  response= common.xml_method(user_model,order_model,line_item,bill_address_model,ship_address_model,order_new)
  else  
  response="Order from another store"
  end
  end

  def gecko_params
params.require(:home).permit( :object_id,:event,:timestamp,:resource_url)
  end
end
