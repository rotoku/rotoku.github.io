import requests


class Main(object):
  def run(self):
    url = "https://api.github.com"
    headers = {
        "Context-Type": "application/json"
    }
    r = requests.get(url=url, headers=headers)
    status_code = r.status_code
    data = r.json()
    print(f"Status Code: {status_code}")
    index = len(data)
    for i in data:
        print(f"Key: {i} - Value: {data[i]}")


if "__main__" == __name__:
    main = Main()
    main.run()