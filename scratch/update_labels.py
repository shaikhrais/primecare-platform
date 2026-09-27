import json
import os

target_files = [
    r'C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_clinic\assets\translations\en.json',
    r'C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_clinic\assets\translations\es.json',
    r'C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_clinic\assets\translations\fr.json',
    r'C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_corporate\assets\translations\en.json',
    r'C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_corporate\assets\translations\es.json',
    r'C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_corporate\assets\translations\fr.json'
]

replacements = {
    "en.json": {
        "login_identifier_label": "USERNAME",
        "login_security_token_label": "PASSWORD"
    },
    "es.json": {
        "login_identifier_label": "NOMBRE DE USUARIO",
        "login_security_token_label": "CONTRASEÑA"
    },
    "fr.json": {
        "login_identifier_label": "NOM D'UTILISATEUR",
        "login_security_token_label": "MOT DE PASSE"
    }
}

for path in target_files:
    if os.path.exists(path):
        filename = os.path.basename(path)
        with open(path, 'r', encoding='utf-8') as f:
            data = json.load(f)
            
        # Recursive replacement function
        def replace_keys(obj, filename):
            if isinstance(obj, dict):
                for k, v in obj.items():
                    if k in replacements[filename]:
                        obj[k] = replacements[filename][k]
                    elif isinstance(v, (dict, list)):
                        replace_keys(v, filename)
            elif isinstance(obj, list):
                for item in obj:
                    replace_keys(item, filename)
                    
        replace_keys(data, filename)
        
        with open(path, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=4, ensure_ascii=False)
        print(f"Updated labels in {path}")
    else:
        print(f"File not found: {path}")
