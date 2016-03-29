json.array!(@medicines) do |medicine|
  json.extract! medicine, :id, :name, :quantity, :selling_quantity, :expiry_date, :price
  json.url medicine_url(medicine, format: :json)
end
