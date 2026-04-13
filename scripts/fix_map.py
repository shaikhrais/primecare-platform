fp = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\dynamic_registry_map.dart'
try:
    with open(fp, 'r', encoding='utf-8') as f:
        text = f.read()

    text = text.replace('Map<String, ProviderOrFamily>', 'Map<String, dynamic>')
    text = text.replace("import 'package:flutter_riverpod/flutter_riverpod.dart';\n", "")

    with open(fp, 'w', encoding='utf-8') as f:
        f.write(text)
    print('Updated dynamic registry map.')
except Exception as e:
    print(f"Error: {e}")
