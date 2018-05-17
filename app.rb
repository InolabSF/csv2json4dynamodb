csv_name = "#{ARGV[0]}"
return unless csv_name.end_with? ".csv"
name = csv_name.sub(".csv", "")
json_name = csv_name.sub(".csv", ".json")

require 'json'
require 'csv'

ITEM_LINE = 0; TYPE_LINE = 1

# read csv and make json
csv_datas = []
items = []; types = []
csv_reader = CSV.open(csv_name, 'r', :col_sep => ',')
csv_reader.each_with_index do |line, index|
  items = line and next if index == ITEM_LINE
  types = line and next if index == TYPE_LINE

  csv_data = { "PutRequest" => { "Item" => { } } }
  items.each_with_index { |item, index| csv_data["PutRequest"]["Item"][item] = { types[index] => line[index] } }
  csv_datas.push csv_data
end

# write json
File.open(json_name, "w") do |file|
  file.write({name => csv_datas}.to_json)
end
