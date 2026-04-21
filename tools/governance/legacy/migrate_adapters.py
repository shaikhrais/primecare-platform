import os
import re

def migrate_adapters(start_dir):
    adapter_count = 0
    for root, dirs, files in os.walk(start_dir):
        for file in files:
            if not file.endswith('_adapter.dart'):
                continue
            
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            original_content = content
            
            # Simple but effective regex replacement for the type casting issue.
            # Match ViewModel.fromJson(snapshot)
            # We use a non-greedy match for the ViewModel name
            # Pattern: ([A-Za-z0-9]+ViewModel)\.fromJson\(snapshot\)
            pattern = r'([A-Za-z0-9]+ViewModel)\.fromJson\(snapshot\)'
            replacement = r'\1.fromJson(snapshot as Map<String, dynamic>)'
            
            content = re.sub(pattern, replacement, content)
            
            if content != original_content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                adapter_count += 1
                print(f"Refactored type casting in {file}")

    print(f"Total adapters refactored: {adapter_count}")

if __name__ == "__main__":
    migrate_adapters('packages/primecare_adapters/lib/src')
