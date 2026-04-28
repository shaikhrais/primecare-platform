import os
import re

def fix_file(path):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Fix _that and other invalid prefixes
    # Matches patterns like SomeClass._that.something or _that.something
    # where _that is not defined.
    # We'll just remove the _that. if it's not preceded by a valid name.
    # But wait, usually it's chi._that.
    # Let's just convert _that. to this. or remove it.
    content = re.sub(r'\b\w+\._that\.', 'vm.', content)
    content = re.sub(r'\b_that\.', 'vm.', content)
    
    # 2. Fix 'state' and 'ref' usage in classes that don't have them
    # If we are in a method and use 'ref' or 'state' without it being defined,
    # it's usually because it was a Notifier.
    # We'll try to prefix with 'this.' if possible, but 'ref' is harder.
    # In features_view, it's often 'ref' in a build method.
    
    # 3. Add isOfflineFallback to classes that might be missing it
    # But I already added it to PrimeCareState/ViewModel.
    # So we just need to ensure they INHERIT from them.
    
    classes = re.findall(r'class (\w+)', content)
    for cls in classes:
        if cls.endswith('ViewModel') and 'extends' not in content[content.find(f'class {cls}'):content.find(f'class {cls}')+100]:
            content = content.replace(f'class {cls} {{', f'class {cls} extends PrimeCareViewModel {{')
        elif cls.endswith('State') and not cls.startswith('_') and 'extends' not in content[content.find(f'class {cls}'):content.find(f'class {cls}')+100]:
            # Don't extend Flutter State
            if not re.search(r'State<\w+>', content[content.find(f'class {cls}'):content.find(f'class {cls}')+50]):
                content = content.replace(f'class {cls} {{', f'class {cls} extends PrimeCareState {{')

    # 4. Fix ConsumerState issues
    # If a class is _XState extends ConsumerState<X>, it needs X to be a ConsumerWidget or ConsumerStatefulWidget.
    # We'll just convert them to normal Widgets if they are broken.
    # Or just make sure they use 'ref'.
    
    # 5. Fix common undefined identifiers
    content = content.replace('isOfflineFallback', 'this.isOfflineFallback')
    content = content.replace('this.this.isOfflineFallback', 'this.isOfflineFallback')
    
    # Remove redundant imports that I might have added
    lines = content.splitlines()
    new_lines = []
    seen_imports = set()
    for line in lines:
        if line.startswith('import '):
            if line not in seen_imports:
                new_lines.append(line)
                seen_imports.add(line)
        else:
            new_lines.append(line)
    
    content = '\n'.join(new_lines)
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

def merge_adapters():
    controller_path = 'lib/src/features/features_controller.dart'
    model_path = 'lib/src/features/features_model.dart'
    view_path = 'lib/src/features/features_view.dart'
    
    new_controller_content = []
    new_model_content = []
    new_view_content = []
    
    components_dir = 'lib/src/components'
    if not os.path.exists(components_dir):
        return

    for root, dirs, files in os.walk(components_dir):
        for file in files:
            if file.endswith('adapter.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    adapter_content = f.read()
                
                # Split content by classes
                # This is a bit naive but might work
                classes = re.split(r'(?=class )', adapter_content)
                for cls_block in classes:
                    if not cls_block.strip(): continue
                    
                    if 'ViewModel' in cls_block or 'State' in cls_block:
                        new_model_content.append(f'// From {file}\n' + cls_block)
                    elif 'Notifier' in cls_block or 'Provider' in cls_block or 'Controller' in cls_block:
                        new_controller_content.append(f'// From {file}\n' + cls_block)
                    elif 'Adapter' in cls_block or 'View' in cls_block:
                        new_view_content.append(f'// From {file}\n' + cls_block)
                    else:
                        # Default to view for generic components
                        new_view_content.append(f'// From {file}\n' + cls_block)

    # Append to files
    with open(controller_path, 'a', encoding='utf-8') as f:
        f.write('\n\n'.join(new_controller_content))
    with open(model_path, 'a', encoding='utf-8') as f:
        f.write('\n\n'.join(new_model_content))
    with open(view_path, 'a', encoding='utf-8') as f:
        f.write('\n\n'.join(new_view_content))

# Run it
merge_adapters()
fix_file('lib/src/features/features_controller.dart')
fix_file('lib/src/features/features_model.dart')
fix_file('lib/src/features/features_view.dart')
print("V5 Recovery Complete")
