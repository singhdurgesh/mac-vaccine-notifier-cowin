module VaccineNotifier
  while true
    system "ruby tmp/vaccine_slot_finder.rb"
    # Check Every 5 minutes -> 300 seconds
    system "sleep 300"
  end
end
