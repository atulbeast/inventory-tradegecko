require './lib/model_helper.rb'
namespace :order do 
    desc 'check order status'
    task :check_status => :environment do
            @gecko = Gecko::Client.new(ENV['OAUTH_ID'],ENV['OAUTH_SECRET'] )
            access_token = OAuth2::AccessToken.new(@gecko.oauth_client, ENV['ACCESS_TOKEN'])
            @gecko.access_token = access_token

        common=ModelHelper.new
    Order.all.each do |item|
        order_main=@gecko.Order.find(item.order_id)
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
    common.xml_method(user_model,order_model,line_item,bill_address_model,ship_address_model,order_new)
    else  
    response="Order from another store"
    end 
    end

    end

end
