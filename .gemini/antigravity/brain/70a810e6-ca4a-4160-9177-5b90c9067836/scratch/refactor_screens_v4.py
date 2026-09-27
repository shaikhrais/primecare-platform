import os
import re

SCREEN_ROOT = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\screens\offices'

REPLACEMENT_TEMPLATE = """class {class_name} extends ConsumerWidget {{
  const {class_name}({{super.key}});

  @override
  Widget build(Widget context, WidgetRef ref) => PageTemplate.orchestrate(
        title: '{title}',
        subtitle: '{subtitle}',
        provider: {provider},
      );
}}
"""

def clean_imports(content):
    # Remove imports that are likely no longer needed
    lines = content.split('\n')
    new_lines = []
    redundant = ['lucide_icons', 'material.dart'] # PageTemplate handles these
    for line in lines:
        if 'import' in line and any(r in line for r in redundant):
            continue
        new_lines.append(line)
    return '\n'.join(new_lines)

def refactor_screens():
    for root, dirs, files in os.walk(SCREEN_ROOT):
        for file in files:
            if file.endswith('.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                if 'PageTemplate.orchestrate' in content: continue
                
                # Extract Class Name
                class_match = re.search(r'class (.*?) ', content)
                if not class_match: continue
                class_name = class_match.group(1)
                
                # Extract Provider
                provider_match = re.search(r'ref\.watch\((.*?)\)', content)
                if not provider_match: continue
                provider = provider_match.group(1).strip()
                
                # Extract Title (look for the first Text widget in the Column)
                title_match = re.search(r"Text\(\s*'(.*?)'", content)
                title = title_match.group(1) if title_match else class_name.replace('Screen', '').replace('_', ' ').title()
                
                # Extract Subtitle (look for the second Text widget or a common subtitle pattern)
                subtitle_match = re.search(r"Text\(\s*'(.*?)'.*?\),", content[content.find(title or ''):])
                subtitle = subtitle_match.group(1) if subtitle_match else "Real-time dashboard managed by the PrimeCare Factory Engine."
                
                # Construct New Class
                # We need to preserve imports but replace the class.
                # Find where class starts
                class_start = content.find(f"class {class_name}")
                if class_start == -1: continue
                
                header = clean_imports(content[:class_start])
                new_class = REPLACEMENT_TEMPLATE.format(
                    class_name=class_name,
                    title=title,
                    subtitle=subtitle,
                    provider=provider
                )
                
                new_content = header + new_class
                
                with open(path, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f"Refactored and Purged: {file}")

if __name__ == "__main__":
    refactor_screens()
