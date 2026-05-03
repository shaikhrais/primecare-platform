import os
import re

registry_dir = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_governance\lib\core\governance\registries'

for filename in os.listdir(registry_dir):
    if filename.endswith('.dart'):
        filepath = os.path.join(registry_dir, filename)
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Replace SCREEN___ with SCREEN_
        content = content.replace("SCREEN___", "SCREEN_")
        
        # Replace redundant underscores like SCREEN_WORKFLOWS_AND_FORMS_... with SCREEN_WF_... or just clean them
        # Let's just remove the AND_FORMS part if it matches my migration pattern
        content = content.replace("WORKFLOWS_AND_FORMS_", "WF_")
        
        # Clean up double underscores
        content = content.replace("__", "_")
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)

print("Normalization complete.")
