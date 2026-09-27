import json

FIXTURE_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\cypress\fixtures\generated\screen-tests.json"

with open(FIXTURE_PATH, "r", encoding="utf-8") as f:
    master_fixture = json.load(f)

for test in master_fixture["tests"]:
    if test["test_code"] == "psw_shift_tracker_runtime":
        print(json.dumps(test, indent=2))
