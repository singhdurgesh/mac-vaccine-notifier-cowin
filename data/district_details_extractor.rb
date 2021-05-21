require 'csv'
require "json"

file = File.open("states_list.rb")
file_data = file.read
states_data = JSON.parse(file_data)
states_list = states_data["states"]

states_list.find_all do |state|
  cmd = "python district_data_extractor.py "+state["state_id"].to_s+" > ../tmp/state_" + state["state_id"].to_s+".rb"
  system cmd
end

states_list.find_all do |state|
  file_name = state["state_name"].gsub(/\s+/, "") + ".csv"
  CSV.open(file_name, "w") do |f|
    f << ["District", "Disctrict Id"]

    district_data_file = "../tmp/state_"+state["state_id"].to_s+".rb"
    file = File.open(district_data_file)
    file_data = file.read
    all_districts_data = JSON.parse(file_data)

    all_districts = all_districts_data["districts"]
    all_districts.find_all do |district|
      f << [district["district_name"], district["district_id"]]
    end
  end
end


