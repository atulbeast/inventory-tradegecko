require 'net/https'
require 'uri'
require 'savon'
#require 'awesome_print'
class ModelHelper

def address_method(model)
    a_model=Address.new
    a_model[:address_id]=model[:id]
    a_model[:first_name]=model[:first_name]
    a_model[:last_name]=model[:last_name]
    a_model[:company_name]=model[:company_name]
    a_model[:address_one]=model[:address1]
    a_model[:city]=model[:city]
    a_model[:state]=model[:state]
    a_model[:postal_code]=model[:zip_code]
    #a_model.save
    a_model
end
def user_method(model)
u_model=User.new
u_model[:first_name]=model[:first_name]
u_model[:last_name]=model[:last_name]
#u_model[:company_name]=model[:company_name]
#u_model[:address_one]=model[:address_one]
#u_model[:status]=model[:status]
#u_model[:phone_number]=model[:phone_number]
u_model[:uid]=model[:id]
u_model[:email]=model[:email]
# u_model[:tax_exempt]=model[:tax_exempt]
# u_model[:tax_exempt_approved]=model[:tax_exempt_approved]
#u_model[:commercial]=model[:commercial]
#u_model.save
u_model
end

def order_method(model)
o_model=Order.new
o_model[:order_id]= model[:id]
o_model[:order_line_item_ids]= model[:order_line_item_ids].map(&:inspect).join(', ')
#o_model[:company_id]= model[:company_id]
#o_model[:contact_id]= model[:contact_id]
o_model[:shipping_address_id]= model[:shipping_address_id]
o_model[:billing_address_id]= model[:billing_address_id]
o_model[:user_id]= model[:user_id]
#o_model[:assignee_id]= model[:assignee_id]
#o_model[:stock_location_id]= model[:stock_location_id]
o_model[:currency_id]= model[:currency_id]
#o_model[:default_price_list_id]= model[:default_price_list_id]
o_model[:order_number]= model[:order_number]
o_model[:phone_number]= model[:phone_number]
#o_model[:email]= model[:email]
o_model[:notes]= model[:notes]
#o_model[:reference_number]= model[:reference_number]
o_model[:status]= model[:status]
o_model[:packed_status]= model[:packed_status]
o_model[:fulfillment_status]= model[:fulfillment_status]
o_model[:invoice_status]= model[:invoice_status]
o_model[:payment_status]= model[:payment_status]
o_model[:return_status]= model[:return_status]
o_model[:returning_status]= model[:returning_status]
o_model[:shippability_status]= model[:shippability_status]
o_model[:backordering_status]= model[:backordering_status]
o_model[:issued_at]= model[:issued_at]
o_model[:ship_at]= model[:ship_at]
o_model[:tags]= model[:tags].map(&:inspect).join(', ')
o_model[:entry_date]=model[:created_at]
#o_model[:tax_override]= model[:tax_override]
#o_model[:tax_label]= model[:tax_label]
#o_model[:source_url]= model[:source_url]
#o_model[:document_url]= model[:document_url]
#o_model[:source_id]= model[:source_id]
#o_model[:total]= model[:total]
#o_model[:tracking_number]= model[:tracking_number]
o_model.save
o_model
end



def line_item_method(model)
l_model=LineItem.new
l_model[:quantity]=model[:quantity].to_i
l_model[:price]=model[:price]
l_model[:discount]=model[:discount]
l_model[:tax_rate_override]=model[:tax_rate_override]
#l_model[:tax_rate]=model[:tax_rate]
l_model
end


def xml_method(user_model,order_model,line_model,address_model,ship_model,is_new)
  
# Create the http object
url = "https://client.orders.fulfillmentworks.com/pmomsws/order.asmx"

# Raw SOAP XML to be passed
# TODO : Date should be dynamic
create_line_obj=""
line_model.each do |d|
    create_line_obj+= "<OfferOrdered>
<Offer>
  <Header>
    <ID>MSCON002</ID>
  </Header>
</Offer>
<Quantity>#{d.quantity}</Quantity>
<OrderShipToKey>
  <Key>0</Key>
</OrderShipToKey>
<UnitPrice>#{d.price}</UnitPrice>
<ShippingHandling>0.00</ShippingHandling>
<Discounts>#{d.discount}</Discounts>
</OfferOrdered>"
end



data = <<-EOF
<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">
  <soap:Header>
    <AuthenticationHeader xmlns=\"http://sma-promail/\">
      <Username>ws_ConsciousLive</Username>
      <Password>Ag00DCau$3</Password>
    </AuthenticationHeader>
  </soap:Header>
  <soap:Body>
    <AddOrder xmlns=\"http://sma-promail/\">
      <order>
        <Header>
          <ID>CS-#{order_model.order_id}</ID>
          <EntryDate>#{order_model.created_at.xmlschema}</EntryDate>
          <OrderEntryView>
            <Description>Default</Description>
          </OrderEntryView>
          <InsertDate>#{order_model.created_at.xmlschema}</InsertDate>
        </Header>
        <Classification>
          <Source>
            <Description>TradeGecko</Description>
        </Source>
        </Classification>
        <Shipping>
        <FreightCode>U11</FreightCode>
        <FreightCodeDescription>Ground</FreightCodeDescription>
        </Shipping>
        <OrderedBy>
          <FirstName>#{user_model.first_name}</FirstName>
          <LastName>#{user_model.last_name}</LastName>
          <CompanyName>#{address_model.company_name}</CompanyName>
          <Address1>#{address_model.address_one}</Address1>
          <City>#{address_model.city}</City>
          <State>#{address_model.state}</State>
          <PostalCode>#{address_model.postal_code}</PostalCode>
          <Email>#{user_model.first_name}</Email>
          <UID>#{user_model.uid}</UID>
          <TaxExempt>#{user_model.tax_exempt||false}</TaxExempt>
          <TaxExemptApproved>#{user_model.tax_exempt_approved||false}</TaxExemptApproved>
          <Commercial>false</Commercial>
        </OrderedBy>
        <ShipTo>
        <OrderShipTo>
        <FirstName>#{ship_model.first_name}</FirstName>
        <LastName>#{ship_model.last_name}</LastName>
        <Address1>#{ship_model.address_one}</Address1>
        <City>#{ship_model.city}</City>
        <State>#{ship_model.state}</State>
        <PostalCode>#{ship_model.postal_code}</PostalCode>
        <UID>#{user_model.uid}</UID>
        <TaxExempt>#{user_model.tax_exempt||false}</TaxExempt>
        <TaxExemptApproved>#{user_model.tax_exempt_approved||false}</TaxExemptApproved>
        <Commercial>false</Commercial>
        <Flag>Other</Flag><Key>0</Key>
        </OrderShipTo>
        </ShipTo>
        <BillTo>
        <TaxExempt>#{user_model.tax_exempt||false}</TaxExempt>
        <TaxExemptApproved>#{user_model.tax_exempt_approved||false}</TaxExemptApproved>
        <Commercial>false</Commercial>
          <Flag>OrderedBy</Flag>
        </BillTo>
        <Offers>
        #{create_line_obj}
          
        </Offers>
      </order>
    </AddOrder>
  </soap:Body>
</soap:Envelope>
EOF

# # Set Headers
# SOAPAction is mandatory

File.open("out.txt", 'w') {|f| f.write(data) }
headers = {
  #  'Cache-Control' => 'no-cache', 
  #  'Pragma' => 'no-cache', 
  #  'Content-length' => data.length.to_s,
  #  'timeout' => '10',
  #  'Content-Type' => 'text/xml; charset=utf-8',
  #  'Accept' => 'text/xml',
    :username => "ws_ConsciousLive",
    :password => "Ag00DCau"
    #, "basic_auth" => ["ws_ConsciousLive", "Ag00DCau"]
}
# if is_new  #just for now chill remove not
# result= http.post(uri.path, data, headers)
# else
# result= http.put(uri.path, data, headers)
# end
if is_new
client = Savon.client(
  wsdl: 'https://client.orders.fulfillmentworks.com/pmomsws/order.asmx?wsdl',
  soap_header: 
    headers
)
d=client.call(:add_order, xml: data)
puts d
end



end




end