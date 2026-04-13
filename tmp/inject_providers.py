import os

providers_path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\adapter_providers.dart'
features_dir = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\features'

def to_pascal_case(snake_str):
    return ''.join(x.capitalize() for x in snake_str.split('_'))

def to_camel_case(snake_str):
    components = snake_str.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])

new_content = "import 'package:flutter_riverpod/flutter_riverpod.dart';\n"

for entry in os.listdir(features_dir):
    full_path = os.path.join(features_dir, entry)
    if os.path.isdir(full_path):
        new_content += f"import '../features/{entry}/data/adapters/{entry}_adapter.dart';\n"
        new_content += f"import '../features/{entry}/domain/models/{entry}_view_model.dart';\n"

new_content += "\n"

for entry in os.listdir(features_dir):
    full_path = os.path.join(features_dir, entry)
    if os.path.isdir(full_path):
        pascal_name = to_pascal_case(entry)
        camel_name = to_camel_case(entry)
        
        new_content += f'''
final {camel_name}AdapterProvider = Provider<{pascal_name}Adapter>((ref) {{
  return {pascal_name}Adapter();
}});

final {camel_name}ViewModelProvider = FutureProvider<{pascal_name}ViewModel>((ref) async {{
  final adapter = ref.watch({camel_name}AdapterProvider);
  return await adapter.getData();
}});
'''

with open(providers_path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print('Provider bindings generated successfully for adapter_providers.dart.')
