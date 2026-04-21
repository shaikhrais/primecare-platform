import os
import re

FEATURES_DIR = "C:/Users/Admin2/Documents/GitHub/primecare-platform/packages/flutter_core/lib/features"
TARGET_PATH = "C:/Users/Admin2/Documents/GitHub/primecare-platform/packages/primecare_adapters/lib/src/registry/05_G_primecare_form_enum.dart"

def to_camel_case(name):
    # Remove 'Screen' suffix
    if name.endswith('Screen'):
        name = name[:-6]
    # lowercase first char
    return name[0].lower() + name[1:]

def to_title_case(name):
    # Split camelCase and capitalize
    return re.sub(r'(?<!^)(?=[A-Z])', ' ', name).title()

def restore():
    print(f"Scanning for screens in {FEATURES_DIR}")
    
    screens = set()
    
    # 1. Scan filesystem for *_screen.dart
    for root, dirs, files in os.walk(FEATURES_DIR):
        for file in files:
            if file.endswith('_screen.dart') and not file.startswith('01_I_'):
                # Extract Class Name from file name or content
                # File: 05_U_ceo_dashboard_screen.dart
                # Logic: remove numeric prefix and underscore notation
                name_parts = file.replace('.dart', '').split('_')
                # Filter out numbers and 'U', 'I', 'B' prefixes
                clean_parts = [p for p in name_parts if not (p.isdigit() or len(p) == 1)]
                
                # Join to CamelCase
                class_stem = "".join(p.capitalize() for p in clean_parts)
                enum_name = to_camel_case(class_stem)
                screens.add(enum_name)

    print(f"Found {len(screens)} physical screens.")

    # Sort for consistency
    sorted_screens = sorted(list(screens))

    # Generate Dart code
    lines = [
        "// Layer: 05_REGISTRY_GOVERNANCE",
        "",
        "/// Registry of all hydrated data-bound adapters on the PrimeCare Platform.",
        "/// This enum drives the dynamic dashboard orchestration engine.",
        "enum PrimeCareForm {",
    ]

    for name in sorted_screens:
        label = to_title_case(name)
        lines.append(f"  {name}('{label}'),")

    lines.append(";")
    lines.append("")
    lines.append("  final String label;")
    lines.append("  const PrimeCareForm(this.label);")
    lines.append("}")
    lines.append("")

    # Add Extension for Route
    lines.append("extension PrimeCareFormExtension on PrimeCareForm {")
    lines.append("  String get route {")
    lines.append("    switch (this) {")
    
    for name in sorted_screens:
        route = re.sub(r'(?<!^)(?=[A-Z])', '_', name).upper()
        lines.append(f"      case PrimeCareForm.{name}: return '{route}';")
        
    lines.append("    }")
    lines.append("  }")
    lines.append("}")

    with open(TARGET_PATH, 'w') as f:
        f.write("\n".join(lines))
    
    print(f"Successfully restored {len(sorted_screens)} entries to {TARGET_PATH}")

if __name__ == "__main__":
    restore()
