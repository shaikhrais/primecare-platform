import os
import re

VM_ROOT = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\features'

TEMPLATE = """
  factory {class_name}.assemble({{required bool isOffline}}) {{
    return {class_name}(
      isOfflineFallback: isOffline,
      blueprints: [
        // Standard Zero-Code Orchestration Layout
        StatGridBlueprint(dataPayload: []), // Dynamic KPIs
        ActivityFeedBlueprint(dataPayload: []), // Live Stream
      ],
    );
  }}
"""

def harden_vms():
    for root, dirs, files in os.walk(VM_ROOT):
        for file in files:
            if file.endswith('_view_model.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Extract class name
                match = re.search(r'class (.*?) ', content)
                if not match: continue
                class_name = match.group(1)
                
                if 'assemble' in content: continue
                
                # Insert factory before the closing brace
                new_factory = TEMPLATE.format(class_name=class_name)
                # Find last closing brace
                last_brace = content.rfind('}')
                if last_brace != -1:
                    new_content = content[:last_brace] + new_factory + content[last_brace:]
                    with open(path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"Hardened {file}")

if __name__ == "__main__":
    harden_vms()
