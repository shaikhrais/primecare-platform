import os
import re

INTENTS = {
    'ComplianceHubIntent': '/offices/corporate/roles/compliance_manager/dashboard',
}

base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features"

for root, _, files in os.walk(base_dir):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            updated = False
            for intent_class, route in INTENTS.items():
                if f"class {intent_class}" in content:
                    pattern = r"(" + intent_class + r"\(\)\s*:\s*super\([^)]*)\)"
                    
                    def repl(match):
                        inner = match.group(1)
                        if 'route:' not in inner:
                            if inner.endswith('('):
                                return inner + f"route: '{route}'" + ")"
                            else:
                                return inner + f", route: '{route}'" + ")"
                        return match.group(0)
                        
                    new_content = re.sub(pattern, repl, content)
                    if new_content != content:
                        content = new_content
                        updated = True
            
            if updated:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                print(f"Updated {filepath}")
