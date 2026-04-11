import json
import re

json_dir = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\assets\translations"

with open(r'test_output.txt', 'r', encoding='utf-16') as f:
    log = f.read()

missing_keys = set(re.findall(r"Localization key \[(.*?)\] not found", log))

def set_nested_value(d, keys, value):
    for key in keys[:-1]:
        d = d.setdefault(key, {})
    d[keys[-1]] = value

# load
with open(fr"{json_dir}\en.json", 'r', encoding='utf-8') as f:
    en_data = json.load(f)
with open(fr"{json_dir}\fr.json", 'r', encoding='utf-8') as f:
    fr_data = json.load(f)
with open(fr"{json_dir}\es.json", 'r', encoding='utf-8') as f:
    es_data = json.load(f)

for key in missing_keys:
    parts = key.split('.')
    if len(parts) >= 3:
        office = parts[0]
        role = parts[1]
        field = parts[-1] 
        
        # Determine title
        if field == "title":
            title = role.replace('Manager', ' Manager').replace('Director', ' Director').replace('Coordinator', ' Coordinator').title() + " Dashboard"
            set_nested_value(en_data, parts, title)
            set_nested_value(fr_data, parts, title.replace("Dashboard", "Tableau de Bord"))
            set_nested_value(es_data, parts, title.replace("Dashboard", "Panel"))
        elif field == "subtitle":
            set_nested_value(en_data, parts, "Real-time overview fetched natively via API.")
            set_nested_value(fr_data, parts, "Aperçu en temps réel récupéré nativement via l'API.")
            set_nested_value(es_data, parts, "Visión general en tiempo real obtenida nativamente vía API.")

with open(fr"{json_dir}\en.json", 'w', encoding='utf-8') as f:
    json.dump(en_data, f, indent=2, ensure_ascii=False)
with open(fr"{json_dir}\fr.json", 'w', encoding='utf-8') as f:
    json.dump(fr_data, f, indent=2, ensure_ascii=False)
with open(fr"{json_dir}\es.json", 'w', encoding='utf-8') as f:
    json.dump(es_data, f, indent=2, ensure_ascii=False)

print(f"Added {len(missing_keys)} missing keys to all JSON files.")
