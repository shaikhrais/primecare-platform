# API/service connector utility
import urllib.request
def check_api_status(url):
    try:
        response = urllib.request.urlopen(url, timeout=5)
        return response.getcode() == 200
    except Exception:
        return False
