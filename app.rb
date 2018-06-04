csv_name = "#{ARGV[0]}"
return unless csv_name.end_with? ".csv"
name = csv_name.sub(".csv", "")

require 'json'
require 'csv'

MAX_ITEMS_PER_JSON = 25
ITEM_LINE = 0; TYPE_LINE = 1

# read csv and make json
all_csv_datas = []
items = []; types = []
csv_reader = CSV.open(csv_name, 'r', :col_sep => ',')
csv_reader.each_with_index do |line, index|
  items = line and next if index == ITEM_LINE
  types = line and next if index == TYPE_LINE

  csv_data = { "PutRequest" => { "Item" => { } } }
  items.each_with_index { |item, index| csv_data["PutRequest"]["Item"][item] = { types[index] => line[index] } }
  all_csv_datas.push csv_data
end

# write json
number_of_files = (all_csv_datas.count % MAX_ITEMS_PER_JSON == 0) ? (all_csv_datas.count / MAX_ITEMS_PER_JSON) : (all_csv_datas.count / MAX_ITEMS_PER_JSON) + 1
for i in 0...number_of_files
  last_index = (i+1)*MAX_ITEMS_PER_JSON
  last_index = all_csv_datas.count - 1 if last_index >= all_csv_datas.count
  csv_datas = all_csv_datas[i*MAX_ITEMS_PER_JSON...last_index]
  json_name = csv_name.sub(".csv", "_#{i}.json")
  File.open(json_name, "w") do |file|
    file.write({name => csv_datas}.to_json)
  end
end
