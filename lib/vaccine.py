import http.client
from datetime import date

today = date.today()
today_str = today.strftime("%d-%m-%Y")
# District code of Mirzapur, UP is 677 
# Find all District Code in data/district_codes.rb
cowin_api = "/api/v2/appointment/sessions/public/calendarByDistrict?district_id=677&date=" + today_str

conn = http.client.HTTPSConnection("cdn-api.co-vin.in")
payload = ''
headers = {
  'Accept': 'application/json',
  'Content-Type': 'application/json'
}
conn.request("GET", cowin_api, payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))

