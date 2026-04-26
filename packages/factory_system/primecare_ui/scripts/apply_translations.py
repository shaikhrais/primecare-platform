import json
import os
import re

# Mapping of hardcoded strings to translation keys
MAPPING = {
    "Search institutional workspace...": "navigation.search_hint",
    "User Profile": "navigation.user_profile",
    "Cancel": "common.cancel",
    "Status": "common.status",
    "Draft": "common.draft",
    "Publish": "common.publish",
    "Successfully submitted": "common.success_message",
    "Name": "common.name",
    "Details": "common.details",
    "Date": "common.date",
    "Amount": "common.amount",
    "Category": "common.category",
    "Role": "common.role",
    "Department": "common.department",
    "Read": "common.read",
    "Write": "common.write",
    "Retry Synchronization": "common.retry",
    "No recent activity": "common.no_activity",
    "Aura Intelligence": "aura.intelligence",
    "Search Aura...": "aura.search_hint",
    "Enter structured clinical notes...": "clinical.notes_hint",
    "Successfully tracked and submitted.": "forms.successfully_tracked",
    "First Name": "forms.first_name",
    "Last Name": "forms.last_name",
    "Corporate Email": "forms.corporate_email",
    "Additional Notes / Clearances": "forms.notes",
    "Patient Name": "clinical.patient_name",
    "Heart Rate (bpm)": "clinical.heart_rate",
    "Blood Pressure": "clinical.blood_pressure",
    "Temperature (°C)": "clinical.temperature",
    "Chief Complaint": "clinical.chief_complaint",
    "Medical History": "clinical.medical_history",
}

ROOT_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src"
AUDIT_FILE = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\localization_audit.json"

def apply_translations():
    with open(AUDIT_FILE, 'r', encoding='utf-8') as f:
        audit = json.load(f)

    # Track which files were modified
    modified_files = set()

    for original_text, locations in audit.items():
        if original_text not in MAPPING:
            continue
        
        key = MAPPING[original_text]
        
        for loc in locations:
            rel_path, line_no = loc.split(':')
            abs_path = os.path.join(ROOT_DIR, rel_path)
            
            if not os.path.exists(abs_path):
                print(f"Warning: File not found {abs_path}")
                continue
                
            with open(abs_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Simple replacement for literals in Text(), tooltip, labelText, hintText
            # We want to catch 'Text("Value")' and replace with 'Text("key".tr())'
            # Also handles single quotes
            
            new_content = content
            
            # Pattern for Text("...")
            new_content = new_content.replace(f'Text("{original_text}")', f'Text("{key}".tr())')
            new_content.replace(f"Text('{original_text}')", f'Text("{key}".tr())')
            
            # Pattern for tooltip: "..."
            new_content = new_content.replace(f'tooltip: "{original_text}"', f'tooltip: "{key}".tr()')
            new_content = new_content.replace(f"tooltip: '{original_text}'", f'tooltip: "{key}".tr()')
            
            # Pattern for labelText: "..."
            new_content = new_content.replace(f'labelText: "{original_text}"', f'labelText: "{key}".tr()')
            new_content = new_content.replace(f"labelText: '{original_text}'", f'labelText: "{key}".tr()')
            
            # Pattern for hintText: "..."
            new_content = new_content.replace(f'hintText: "{original_text}"', f'hintText: "{key}".tr()')
            new_content = new_content.replace(f"hintText: '{original_text}'", f'hintText: "{key}".tr()')

            if new_content != content:
                # Add import if not present
                if "import 'package:easy_localization/easy_localization.dart';" not in new_content:
                    new_content = "import 'package:easy_localization/easy_localization.dart';\n" + new_content
                
                with open(abs_path, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                modified_files.add(abs_path)
                print(f"Updated {rel_path} for '{original_text}'")

    print(f"Done. Modified {len(modified_files)} files.")

if __name__ == "__main__":
    apply_translations()
