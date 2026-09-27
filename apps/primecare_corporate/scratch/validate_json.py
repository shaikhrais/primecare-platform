import json
import sys

try:
    with open(r'C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\assets\translations\en.json', 'r', encoding='utf-8') as f:
        json.load(f)
    print("EN JSON is valid")
except Exception as e:
    print(f"EN JSON error: {e}")

try:
    with open(r'C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\assets\translations\fr.json', 'r', encoding='utf-8') as f:
        json.load(f)
    print("FR JSON is valid")
except Exception as e:
    print(f"FR JSON error: {e}")
