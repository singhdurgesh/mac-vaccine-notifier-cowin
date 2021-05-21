import http.client
import sys

state_code = sys.argv[1]
conn = http.client.HTTPSConnection("cdn-api.co-vin.in")
payload = ''
headers = {
  'Accept': 'application/json',
  'Content-Type': 'application/json'
}
conn.request("GET", "/api/v2/admin/location/districts/"+state_code, payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))