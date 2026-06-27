import json
import os
import re

# Paths
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "../../../../"))
PAGE_INVENTORY = os.path.join(ROOT_DIR, ".agents/governance/page_inventory.yaml")
FEATURES_DIR = os.path.join(ROOT_DIR, "packages/factory_system/primecare_ui/lib")
ADAPTERS_DIR = os.path.join(ROOT_DIR, "packages/primecare_adapters/lib")
# Updated to the real target path
LOCALE_KEYS_FILE = os.path.join(ROOT_DIR, "packages/factory_system/primecare_ui/lib/src/shared/src/config/locale_keys.dart")
LOCALE_KEYS_G_FILE = os.path.join(ROOT_DIR, "packages/factory_system/primecare_ui/lib/src/i18n/locale_keys.g.dart")
TRANSLATIONS_DIR = os.path.join(ROOT_DIR, "apps/primecare_corporate/assets/translations")
GOVERNANCE_TRANSLATIONS_DIR = os.path.join(ROOT_DIR, "apps/primecare_governance/assets/translations")

def to_title_case(snake_str):
    # Handle CamelCase too
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1 \2', snake_str)
    s2 = re.sub('([a-z0-9])([A-Z])', r'\1 \2', s1)
    return " ".join(x.capitalize() for x in s2.replace("_", " ").split())

def to_slug(text):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', text)
    s2 = re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1)
    return s2.lower().strip().replace(" ", "_").replace("&", "and").replace("__", "_")

def parse_yaml_inventory():
    """Simple regex parser for the page inventory YAML."""
    if not os.path.exists(PAGE_INVENTORY):
        return [], []
    
    with open(PAGE_INVENTORY, 'r') as f:
        content = f.read()
    
    # Split by '- id:' to handle multi-line items
    blocks = content.split("- id:")[1:]
    items = []
    sections = set()

    for block in blocks:
        # Get ID (first word after - id:)
        id_match = re.search(r'^\s*\"?(\w+)\"?', block)
        if not id_match: continue
        mid = id_match.group(1)
        
        # Get Label
        label_match = re.search(r'label:\s*\"?([\w\s&]+)\"?', block)
        mlabel = label_match.group(1).strip() if label_match else to_title_case(mid)
        
        # Get Section
        section_match = re.search(r'section:\s*\"?([\w\s&]+)\"?', block)
        msection = section_match.group(1).strip() if section_match else "Main"
        
        items.append({"id": mid, "label": mlabel, "section": msection})
        sections.add(msection)
    
    return items, sorted(list(sections))

def scan_dashboard_intents():
    """Scans all *intent.dart files for dashboard keys."""
    dashboards = {}
    
    if not os.path.exists(FEATURES_DIR):
        return dashboards

    for root, _, files in os.walk(FEATURES_DIR):
        for file in files:
            if file.endswith("intent.dart"):
                path = os.path.join(root, file)
                with open(path, 'r') as f:
                    content = f.read()
                
                # Extract role/key from title pattern: dashboards.role.title
                title_match = re.search(r"dashboards\.(\w+)\.title", content)
                if title_match:
                    role = title_match.group(1)
                    if role not in dashboards:
                        dashboards[role] = {
                            "title": to_title_case(role) + " Dashboard",
                            "subtitle": "Access metrics.",
                            "labels": {}
                        }
                    
                    # Extract labels
                    label_matches = re.findall(r"dashboards\." + role + r"\.labels\.(\w+)", content)
                    for label_key in label_matches:
                        dashboards[role]["labels"][label_key] = to_title_case(label_key)
    
    return dashboards

def scan_primecare_ui_registries():
    """Scans domain registries in primecare_ui for titleKey patterns."""
    registries = {}
    registries_dir = os.path.join(ROOT_DIR, "packages/factory_system/primecare_ui/lib/src/shared/src/registry/domain_registries")
    
    if not os.path.exists(registries_dir):
        return registries

    for file in os.listdir(registries_dir):
        if file.endswith(".dart"):
            path = os.path.join(registries_dir, file)
            with open(path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # Find patterns like titleKey: 'admin.governance_monitor.title' or 'corporate.ceo.dashboard.title'
            matches = re.findall(r"titleKey:\s*'([\w.]+)'", content)
            # Also find from registryJson
            matches += re.findall(r"'title':\s*'([\w.]+)'", content)
            
            for full_key in matches:
                parts = full_key.split(".")
                current = registries
                for i, part in enumerate(parts):
                    if i == len(parts) - 1:
                        if part not in current:
                            current[part] = to_title_case(parts[-2] if len(parts) > 1 else part)
                    else:
                        if part not in current:
                            current[part] = {}
                        current = current[part]
    
    return registries

def scan_governance_registries():
    """Scans all domain registries for LocaleKeys.Registries\ patterns."""
    registries = {}
    registries_dir = os.path.join(ROOT_DIR, "apps/primecare_governance/lib/core/governance/registries")
    
    if not os.path.exists(registries_dir):
        return registries

    for file in os.listdir(registries_dir):
        if file.endswith(".dart"):
            path = os.path.join(registries_dir, file)
            with open(path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # Find patterns like 'LocaleKeys.Registries\corporate_GlobalDashboard'
            matches = re.findall(r"LocaleKeys\.Registries\\(\w+)", content)
            for full_key in matches:
                parts = full_key.split("_")
                if len(parts) >= 2:
                    domain = parts[0]
                    sub_key = "_".join(parts[1:])
                    if domain not in registries:
                        registries[domain] = {}
                    registries[domain][to_slug(sub_key)] = to_title_case(sub_key)
    
    return registries

def generate_locale_keys(all_keys):
    """Generates the static LocaleKeys Dart class."""
    content = "// Generated by gen_translations.py - DO NOT EDIT MANUALLY\n"
    content += "abstract class LocaleKeys {\n"
    
    def add_keys(data, prefix=""):
        nonlocal content
        # Sort keys for deterministic output
        for k in sorted(data.keys()):
            v = data[k]
            key_path = f"{prefix}.{k}" if prefix else k
            if isinstance(v, dict):
                add_keys(v, key_path)
            else:
                # Create a valid Dart constant name
                const_name = key_path.replace(".", "_").replace("&", "and").replace("-", "_")
                content += f"  static const String {const_name} = '{key_path}';\n"

    add_keys(all_keys)
    content += "}\n"
    
    os.makedirs(os.path.dirname(LOCALE_KEYS_FILE), exist_ok=True)
    with open(LOCALE_KEYS_FILE, "w") as f:
        f.write(content)
    
    os.makedirs(os.path.dirname(LOCALE_KEYS_G_FILE), exist_ok=True)
    with open(LOCALE_KEYS_G_FILE, "w") as f:
        f.write(content)
    
    print(f"Generated {LOCALE_KEYS_FILE}")
    print(f"Generated {LOCALE_KEYS_G_FILE}")

def scan_codebase_for_keys(en_translations):
    """Scans all Dart files for used LocaleKeys to ensure they are generated and translated."""
    processed_keys = set()
    
    # Scan main packages
    scan_dirs = [
        os.path.join(ROOT_DIR, "packages/factory_system/primecare_ui"),
        os.path.join(ROOT_DIR, "packages/primecare_ui"),
        os.path.join(ROOT_DIR, "apps/primecare_governance/lib")
    ]
    
    for scan_dir in scan_dirs:
        if not os.path.exists(scan_dir): continue
        
        for root_path, _, files in os.walk(scan_dir):
            for file in files:
                if file.endswith(".dart"):
                    path = os.path.join(root_path, file)
                    with open(path, 'r', encoding='utf-8', errors='ignore') as f:
                        content = f.read()
                    
                    # Match LocaleKeys.some_key_name.tr() or LocaleKeys.some_key_name
                    matches = re.findall(r"LocaleKeys\s*\.\s*(\w+)", content)
                    for full_key in matches:
                        if full_key in processed_keys: continue
                        processed_keys.add(full_key)
                        
                        # Handle dashboard patterns: dashboards_<role>_labels_<key>
                        dash_match = re.match(r"dashboards_(\w+)_labels_(\w+)", full_key)
                        if dash_match:
                            role, label_key = dash_match.groups()
                            if "dashboards" not in en_translations: en_translations["dashboards"] = {}
                            if role not in en_translations["dashboards"]:
                                en_translations["dashboards"][role] = {"title": to_title_case(role) + " Dashboard", "subtitle": "Access metrics.", "labels": {}}
                            if "labels" not in en_translations["dashboards"][role]: en_translations["dashboards"][role]["labels"] = {}
                            if label_key not in en_translations["dashboards"][role]["labels"]:
                                en_translations["dashboards"][role]["labels"][label_key] = to_title_case(label_key)
                            continue

def main():
    print("Starting Smart Translation Sync...")
    
    # 1. Gather Data
    nav_items, nav_sections = parse_yaml_inventory()
    dashboards = scan_dashboard_intents()
    registries = scan_governance_registries()
    ui_registries = scan_primecare_ui_registries()
    
    # 2. Build Translation Maps
    en_translations = {
        "navigation": {
            "sections": {to_slug(s): s for s in nav_sections},
            "items": {item["id"]: item["label"] for item in nav_items},
            "footer": {"language": "Language"}
        },
        "dashboards": dashboards, # Scanned from intents (if any)
        "registries": registries,
    }
    
    # Deep merge ui_registries into en_translations
    def deep_merge(dict1, dict2):
        for k, v in dict2.items():
            if k in dict1 and isinstance(dict1[k], dict) and isinstance(v, dict):
                deep_merge(dict1[k], v)
            else:
                dict1[k] = v
    
    deep_merge(en_translations, ui_registries)

    en_translations.update({
        "common": {
            "app_name": "PrimeCare",
            "loading": "Loading...", "save": "Save", "cancel": "Cancel",
            "status": "Status", "name": "Name", "details": "Details",
            "language": {"en": "English", "fr": "French", "es": "Spanish"},
            "no_records": "No records match your criteria.",
            "process_payment": "Process New Payment",
            "close": "Close",
            "confirm_action": "Confirm Action",
            "generate_invoice": "Generate Invoice Entry",
            "allocate_grant": "Allocate Grant Funds"
        },
        "governance": {
            "title": "Governance Dashboard",
            "audit_logs": "Audit Logs",
            "system_monitoring": "System Monitoring",
            "architectural_health": "Architectural Health",
            "ai_insights": "AI Insights & Remediation",
            "discovered_forms": "Discovered Forms",
            "module_entry": "Module Entry",
            "module_name": "Module Name",
            "save_module": "Save Module",
            "role_entry": "Role Entry",
            "role_name": "Role Name",
            "save_role": "Save Role"
        },
        "command_center": {
            "labels": {
                "training_hub_center": "Training Hub Center",
                "volunteer_center": "Volunteer Center",
                "training_center": "Training Center",
                "curriculum_compliance": "Curriculum Compliance"
            }
        },
        "aura": {
            "intelligence": "Aura Intelligence",
            "search_hint": "Search Aura...",
            "auditors_blueprint": "AUDITOR'S BLUEPRINT",
            "structural_contract": "STRUCTURAL CONTRACT",
            "verified_components": "VERIFIED COMPONENTS"
        }
    })
    
    # Merge additional hardcoded dashboards
    if "corporate" not in en_translations["dashboards"]:
        en_translations["dashboards"]["corporate"] = {}
    en_translations["dashboards"]["corporate"]["shareholder_title"] = "Shareholder Dashboard"
    
    if "scheduler" not in en_translations["dashboards"]:
        en_translations["dashboards"]["scheduler"] = {"title": "Scheduler Dashboard", "subtitle": "Manage shifts."}
    
    # Explicitly add missing top-level keys found in analysis
    missing_keys = {
        "hr_manager_dashboard_title": "HR Manager Dashboard",
        "intake_dashboard_title": "Intake Dashboard",
        "intake_dashboard_subtitle": "Manage patient intakes.",
        "intake_coordinator_dashboard_subtitle": "Coordinator insights.",
        "it_security_dashboard_title": "IT Security Dashboard",
        "it_security_dashboard_subtitle": "Security posture.",
        "local_marketing_manager_dashboard_title": "Local Marketing Manager Dashboard",
        "local_marketing_manager_dashboard_subtitle": "Campaign performance.",
        "owner_dashboard_title": "Owner Dashboard",
        "owner_dashboard_subtitle": "Business overview.",
        "partnership_manager_dashboard_title": "Partnership Manager Dashboard",
        "partnership_manager_dashboard_subtitle": "Partner relations.",
        "patient_dashboard_title": "Patient Dashboard",
        "patient_dashboard_subtitle": "Personal health record.",
        "qa_dashboard_title": "QA Dashboard",
        "qa_dashboard_subtitle": "Quality metrics.",
        "quality_assurance_dashboard_title": "Quality Assurance Dashboard",
        "quality_assurance_dashboard_subtitle": "Standard compliance.",
        "receptionist_dashboard_title": "Receptionist Dashboard",
        "receptionist_dashboard_subtitle": "Front desk operations.",
        "training_director_dashboard_title": "Training Director Dashboard",
        "training_director_dashboard_subtitle": "Education oversight.",
        "franchise_owner_dashboard_title": "Franchise Owner Dashboard"
    }
    en_translations.update(missing_keys)
    
    # 3. Scan codebase for loose keys
    scan_codebase_for_keys(en_translations)
    
    # Final pass to ensure all keys discovered by regex but not in map are added
    # We do a second scan to find anything we might have missed in the structure
    scan_dirs = [
        os.path.join(ROOT_DIR, "packages/factory_system/primecare_ui"),
        os.path.join(ROOT_DIR, "packages/primecare_ui"),
        os.path.join(ROOT_DIR, "apps/primecare_governance/lib")
    ]
    all_discovered = set()
    for scan_dir in scan_dirs:
        if not os.path.exists(scan_dir): continue
        for root_path, _, files in os.walk(scan_dir):
            for file in files:
                if file.endswith(".dart"):
                    path = os.path.join(root_path, file)
                    with open(path, 'r', encoding='utf-8', errors='ignore') as f:
                        content = f.read()
                    matches = re.findall(r"LocaleKeys\s*\.\s*(\w+)", content)
                    for m in matches: all_discovered.add(m)

    # Flatten existing keys for checking
    def get_flat_keys(data, prefix=""):
        flat = set()
        for k, v in data.items():
            key_path = f"{prefix}_{k}" if prefix else k
            if isinstance(v, dict):
                flat.update(get_flat_keys(v, key_path))
            else:
                flat.add(key_path)
        return flat
    
    existing_flat = get_flat_keys(en_translations)
    for disc in all_discovered:
        if disc not in existing_flat and disc != "dart":
            # Add as a loose key at top level if not found
            en_translations[disc] = to_title_case(disc)

    # 4. Create French
    fr_translations = json.loads(json.dumps(en_translations))

    
    # Save Files to both Corporate and Governance apps
    for target_dir in [TRANSLATIONS_DIR, GOVERNANCE_TRANSLATIONS_DIR]:
        if not os.path.exists(target_dir): continue
        with open(os.path.join(target_dir, "en.json"), 'w', encoding='utf-8') as f:
            json.dump(en_translations, f, indent=2, ensure_ascii=False)
        with open(os.path.join(target_dir, "fr.json"), 'w', encoding='utf-8') as f:
            json.dump(fr_translations, f, indent=2, ensure_ascii=False)
    
    # 5. Generate Static Dart Keys
    generate_locale_keys(en_translations)
    
    print("Localization Sync Complete.")

if __name__ == "__main__":
    main()
