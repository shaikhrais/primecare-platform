import os
import re

registry_dir = r'apps/primecare_governance/lib/core/governance/registries'

for filename in os.listdir(registry_dir):
    if filename.endswith('.dart'):
        path = os.path.join(registry_dir, filename)
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Rule 1: sourcePath: 'virtual' -> isVirtual: true
        # Rule 2: any status -> LifecycleStatus.completed
        
        # Fix isVirtual for virtual screens
        new_content = re.sub(
            r"(isVirtual:\s*)false(,\s*sourcePath:\s*'virtual')",
            r"\1true\2",
            content
        )
        
        # Fix lifecycleStatus to completed
        new_content = re.sub(
            r"lifecycleStatus:\s*LifecycleStatus\.\w+",
            "lifecycleStatus: LifecycleStatus.completed",
            new_content
        )
        
        if new_content != content:
            print(f"FIXED: {filename}")
            with open(path, 'w', encoding='utf-8') as f:
                f.write(new_content)
