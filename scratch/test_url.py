import urllib.request

def main():
    url = "https://54d34ef7.primecare-clinic.pages.dev/?enable-semantics=true"
    print(f"Fetching {url}...")
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=10) as response:
            print("Status Code:", response.getcode())
            html = response.read().decode('utf-8')
            print("HTML length:", len(html))
            print("HTML snippet:")
            print(html[:1000])
    except Exception as e:
        print("Error:", e)

if __name__ == '__main__':
    main()
