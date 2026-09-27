import os
import re

def camel_to_snake(name):
    name = re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()
    return name

registries_dir = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_governance\lib\core\governance\registries'

for filename in os.listdir(registries_dir):
    if not filename.endswith('.dart'):
        continue
    
    path = os.path.join(registries_dir, filename)
    with open(path, 'r') as f:
        content = f.read()
    
    # Add import if missing
    if "import 'package:primecare_ui/primecare_ui.dart';" not in content:
        content = content.replace("import '../screen_metadata.dart';", 
                                 "import '../screen_metadata.dart';\nimport 'package:primecare_ui/primecare_ui.dart';")
    
    # Replace the pattern
    # 'LocaleKeys.Registries\businessDevelopment_OntarioFinanceRegionalView'
    # 'LocaleKeys.Registries\clinical_Chiropractor'
    
    def replace_key(match):
        domain = match.group(1)
        key = match.group(2)
        
        # Special case for Nurse(RN)Dashboard
        if key == "Nurse(RN)Dashboard":
            return "LocaleKeys.registries_clinical_nurse"
        
        snake_key = camel_to_snake(key)
        
        # Handle cases where domain might be camelCase too (like businessDevelopment)
        # In gen_translations.py we did:
        # domain_key = domain
        # if domain == "businessDevelopment": domain_key = "businessDevelopment"
        # Wait, gen_translations.py doesn't snake_case the domain itself in the constant name?
        # Let's check LocaleKeys.dart again.
        # registries_businessDevelopment_ontario_finance_regional_view
        # Yes, domain stays camelCase if it was camelCase in the file.
        
        return f"LocaleKeys.registries_{domain}_{snake_key}"

    # Regex to match 'LocaleKeys.Registries\domain_Key'
    new_content = re.sub(r"'LocaleKeys\.Registries\\([a-zA-Z0-9]+)_([a-zA-Z0-9\(\)]+)'", replace_key, content)
    
    with open(path, 'w') as f:
        f.write(new_content)
    print(f"Updated {filename}")
