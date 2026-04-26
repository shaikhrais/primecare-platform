import json
import os

langs = ['en', 'fr', 'es', 'ar']
base_dir = r"apps\primecare_corporate\assets\translations"

for lang in langs:
    file_path = os.path.join(base_dir, f"{lang}.json")
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    if "dashboards" not in data: data["dashboards"] = {}
    if "common" not in data["dashboards"]: data["dashboards"]["common"] = {}
    if "labels" not in data["dashboards"]["common"]: data["dashboards"]["common"]["labels"] = {}
    
    data["dashboards"]["common"]["labels"]["chart"] = "Chart"
    
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

print("Injected chart label into JSON files")
