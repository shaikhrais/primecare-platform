import os
import re

# Paths
BASE_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui"
BIG_3 = [
    os.path.join(BASE_DIR, "lib", "src", "features", "features_model.dart"),
    os.path.join(BASE_DIR, "lib", "src", "features", "features_controller.dart"),
    os.path.join(BASE_DIR, "lib", "src", "features", "features_view.dart")
]

# Features to identify prefixes (based on folder names usually)
FEATURE_PREFIXES = [
    "AdministrativeForms", "AdvancedSettings", "AiAnalytics", "AiChat", "Aura",
    "Billing", "Clinical", "Dashboard", "Employee", "Enterprise", "Finance",
    "HumanResources", "Inventory", "Laboratory", "Medical", "Nursing",
    "Operations", "Patient", "Pharmacy", "Radiology", "Reports", "Scheduling",
    "Security", "SupplyChain", "Telemedicine", "Workflow"
]

def extract_mappings():
    mappings = {}
    for file_path in BIG_3:
        if not os.path.exists(file_path):
            continue
        with open(file_path, "r", encoding="utf-8") as f:
            content = f.read()
            # Match class definitions, provider names, etc.
            # Example: class AdministrativeFormsApproveLeaveRequestFormDto
            # Also catch things like: final administrativeFormsApproveLeaveRequestFormProvider
            
            # Look for CamelCase words starting with a known prefix
            for prefix in FEATURE_PREFIXES:
                pattern = rf"\b({prefix}([A-Z][a-zA-Z0-9_]*))\b"
                matches = re.findall(pattern, content)
                for full_name, suffix in matches:
                    if suffix and suffix[0].isupper():
                        mappings[suffix] = full_name
    return mappings

def apply_mappings(mappings):
    # Sort mappings by length descending to avoid partial replacements
    sorted_keys = sorted(mappings.keys(), key=len, reverse=True)
    
    total_files = 0
    total_replaces = 0
    
    # Files to process (The Big 3 themselves, plus everything in src/features)
    files_to_fix = BIG_3[:]
    for root, _, files in os.walk(os.path.join(BASE_DIR, "lib", "src", "features")):
        for file in files:
            if file.endswith(".dart"):
                files_to_fix.append(os.path.join(root, file))
    
    # Also fix registry and entry points
    files_to_fix.append(os.path.join(BASE_DIR, "lib", "primecare_ui.dart"))
    
    for file_path in set(files_to_fix):
        if not os.path.exists(file_path):
            continue
            
        with open(file_path, "r", encoding="utf-8") as f:
            content = f.read()
        
        original_content = content
        
        for naked in sorted_keys:
            prefixed = mappings[naked]
            
            def replacer(match):
                # Check if already prefixed
                full_text = match.string
                start = match.start()
                # Check preceding chars for any prefix
                for p in FEATURE_PREFIXES:
                    if start >= len(p) and full_text[start-len(p):start] == p:
                        return match.group(0) # Already prefixed
                return prefixed

            pattern = rf"\b{naked}\b"
            content, count = re.subn(pattern, replacer, content)
            total_replaces += count
            
        if content != original_content:
            with open(file_path, "w", encoding="utf-8") as f:
                f.write(content)
            total_files += 1
            
    print(f"Fixed {total_replaces} names across {total_files} files.")

if __name__ == "__main__":
    print("Extracting mappings from Big 3...")
    mappings = extract_mappings()
    print(f"Found {len(mappings)} unique mappings.")
    # Filter out mappings that might be too generic
    mappings = {k: v for k, v in mappings.items() if len(k) > 5}
    print(f"Applying {len(mappings)} high-confidence mappings...")
    apply_mappings(mappings)
