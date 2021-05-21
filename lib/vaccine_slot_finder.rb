module VaccineSlotFinder
  require "json"
  system "python tmp/vaccine.py > tmp/center_details.rb"
  file = File.open("tmp/center_details.rb")
  file_data = file.read
  all_centers_data = JSON.parse(file_data)

  # result data
  centers_data = all_centers_data["centers"]
  results = []
  flag = 0
  centers_data.find_all do |center|
    sessions = center["sessions"]
    flag += 1
    sessions.find_all do |session|
      if session["min_age_limit"] == 18 && !session["available_capacity"].zero?
        results.append [center["name"], center["address"], session["date"], session["available_capacity"], center["pincode"]]
      end
    end
  end

  # system "rm tmp/center_details.rb"

  notification = "found #{flag} centers \n"
  if results.count.zero?
    notification += "No Slots available for 18+ for now in Varansi UP"
  else
    results.find_all do |result|
      notification += result[0] + " Available No.: " + result[3].to_s + " pin: " + result[4].to_s + " On " + result[2].to_s + "\n"
    end
  end
  cmd = if results.count.zero?
          "/usr/bin/osascript -e 'display notification \"#{notification}\"'"
        else
          "/usr/bin/osascript -e 'display notification \"#{notification}\" sound name \"Glass\"'"
        end
  log_cmd = " echo \"#{Time.now} #{notification}\" >> tmp/vaccine_finder.log"
  system cmd unless results.count.zero?
  system log_cmd
end
