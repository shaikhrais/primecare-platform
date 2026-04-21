import os
import re

BASE_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
ENUM_FILE = os.path.join(BASE_DIR, "packages/flutter_core/lib/adapters/primecare_form_enum.dart")
WAREHOUSE_FILE = os.path.join(BASE_DIR, "packages/factory_system/primecare_ui/lib/src/warehouse/component_warehouse.dart")
PLACEHOLDER_DIR = os.path.join(BASE_DIR, "packages/factory_system/primecare_ui/lib/src/components/generated_placeholders")
PLACEHOLDER_FILE = os.path.join(PLACEHOLDER_DIR, "primecare_placeholders.dart")

def get_all_enums():
    enums = []
    if not os.path.exists(ENUM_FILE):
        return enums
    with open(ENUM_FILE, 'r', encoding='utf-8') as f:
        content = f.read()
        # Regex to find: enumName('idValue')
        # Example: aWSAuthContext('aWSAuthContext'),
        matches = re.finditer(r'(\w+)\(\s*\'([\w\s-]+)\'\s*\)', content)
        for m in matches:
            enum_name = m.group(1)
            id_value = m.group(2)
            enums.append((enum_name, id_value))
    return enums

def get_handled_ids():
    handled = set()
    if not os.path.exists(WAREHOUSE_FILE):
        return handled
    with open(WAREHOUSE_FILE, 'r', encoding='utf-8') as f:
        content = f.read()
        # Find 'id': ... in _registry
        matches = re.finditer(r'\'([\w\s-]+)\'\s*:', content)
        for m in matches:
            handled.add(m.group(1))
    return handled

def to_pascal_case(s):
    # Remove dots and underscores, captialize words
    s = s.replace('.', '_')
    return ''.join(word.capitalize() for word in re.split(r'[\s_-]', s))

def generate_placeholder_code(enum_name, id_value):
    class_name = to_pascal_case(enum_name) + "Placeholder"
    return f"""
class {class_name} extends StatelessWidget {{
  final dynamic data;
  const {class_name}({{super.key, this.data}});

  @override
  Widget build(BuildContext context) {{
    final ds = PrimeCareDesignSystem.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ds.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ds.colors.borderSubtle),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.component, color: ds.colors.primary.withValues(alpha: 0.5), size: 48),
          const SizedBox(height: 16),
          Text(
            '{id_value.upper()}',
            style: TextStyle(
              color: ds.colors.textPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This component is currently a placeholder for the {enum_name} intent.',
            textAlign: TextAlign.center,
            style: TextStyle(color: ds.colors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }}
}}
"""

def main():
    print(f"Base Directory: {BASE_DIR}")
    
    if not os.path.exists(PLACEHOLDER_DIR):
        os.makedirs(PLACEHOLDER_DIR)
        print(f"Created directory: {PLACEHOLDER_DIR}")

    all_enums = get_all_enums()
    handled_ids = get_handled_ids()
    
    missing = [e for e in all_enums if e[1] not in handled_ids]
    
    print(f"Found {len(all_enums)} total enums.")
    print(f"Found {len(handled_ids)} handled IDs in Warehouse.")
    print(f"Generating {len(missing)} placeholders.")
    
    if not missing:
        print("No missing components found. Gap already closed.")
        return

    with open(PLACEHOLDER_FILE, 'w', encoding='utf-8') as f:
        f.write("import 'package:flutter/material.dart';\n")
        f.write("import 'package:primecare_ui/src/theme/design_system.dart';\n")
        f.write("import 'package:lucide_icons/lucide_icons.dart';\n\n")
        for enum_name, id_value in missing:
            f.write(generate_placeholder_code(enum_name, id_value))
    print(f"Generated {PLACEHOLDER_FILE}")
            
    # Update Warehouse
    if os.path.exists(WAREHOUSE_FILE):
        with open(WAREHOUSE_FILE, 'r', encoding='utf-8') as f:
            lines = f.readlines()
            
        new_lines = []
        import_added = False
        registry_inserted = False
        
        import_statement = "import '../components/generated_placeholders/primecare_placeholders.dart';\n"
        
        for line in lines:
            if not import_added and line.startswith("import '../components/analytics/"):
                new_lines.append(import_statement)
                import_added = True
            
            new_lines.append(line)
            
            if not registry_inserted and "_registry = {" in line:
                for enum_name, id_value in missing:
                    class_name = to_pascal_case(enum_name) + "Placeholder"
                    new_lines.append(f"    '{id_value}': (context, payload) => {class_name}(data: payload),\n")
                registry_inserted = True
                
        with open(WAREHOUSE_FILE, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
        print(f"Updated {WAREHOUSE_FILE}")
    else:
        print(f"ERROR: Warehouse file not found at {WAREHOUSE_FILE}")
        
    print("Bridge operation complete!")

if __name__ == "__main__":
    main()
