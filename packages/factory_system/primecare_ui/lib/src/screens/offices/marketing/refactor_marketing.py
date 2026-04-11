import os
import re

directory = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\screens\offices\marketing'

files = os.listdir(directory)

for filename in files:
    if not filename.endswith('.dart'):
        continue
    
    filepath = os.path.join(directory, filename)
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Check if it's already refactored
    if 'PageTemplate' in content and 'AssemblyLine' in content:
        continue
    
    # Extract Class Name
    match = re.search(r'class (\w+) extends ConsumerWidget', content)
    if not match:
        continue
    class_name = match.group(1)
    
    # Extract Provider
    provider_match = re.search(r'ref\.watch\((\w+)\(', content)
    provider = provider_match.group(1) if provider_match else 'headOfMarketingDashboardDataProvider'
    
    # Extract Title (fallback to class name words)
    title_match = re.search(r"Text\(\s*'([^']+)'", content)
    title = title_match.group(1) if title_match else class_name.replace('Screen', '').replace('HeadOfMarketing', 'Marketing ')
    
    # Build new content
    new_content = f"""import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class {class_name} extends ConsumerWidget {{
  const {class_name}({{super.key}});

  @override
  Widget build(BuildContext context, WidgetRef ref) {{
    return PageTemplate(
      title: '{title}',
      provider: {provider}('all'),
      builder: (context, ref, HeadOfMarketingDashboardViewModel vm) => AssemblyLine(
        blueprints: vm.blueprints,
      ),
    );
  }}
}}
"""
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_content)
    print(f"Refactored {filename}")
