import json
import os

path = r"cypress/fixtures/generated/screen-tests.json"
if os.path.exists(path):
    with open(path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    codes = [t.get('test_code') for t in data.get('tests', [])]
    print(f"Total tests: {len(codes)}")
    print(f"First 20 codes: {codes[:20]}")
else:
    print("File not found")
