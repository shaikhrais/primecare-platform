import re
import os

# CONFIGURATION
TARGET_FILES = [
    r'lib\src\features\features_model.dart',
    r'lib\src\features\features_controller.dart',
    r'lib\src\features\features_view.dart'
]

BLACKLIST = {
    'Object', 'String', 'int', 'double', 'bool', 'List', 'Map', 'Set', 'dynamic',
    'Widget', 'BuildContext', 'State', 'StatefulWidget', 'StatelessWidget', 'Container',
    'Row', 'Column', 'Text', 'Icon', 'Button', 'Card', 'Scaffold', 'AppBar', 'Drawer',
    'Material', 'Color', 'EdgeInsets', 'BorderRadius', 'TextStyle', 'BoxDecoration',
    'Alignment', 'CrossAxisAlignment', 'MainAxisAlignment', 'Size', 'SizedBox',
    'Iterable', 'Future', 'Stream', 'Type', 'void', 'override', 'const', 'final',
    'var', 'class', 'extends', 'with', 'implements', 'import', 'export', 'part', 'of',
    'PrimeCareViewModel', 'PrimeCareState', 'PrimeCareController', 'PrimeCareAdapter',
    'ConsumerWidget', 'WidgetRef', 'Provider', 'StateProvider', 'ChangeNotifierProvider',
    'AsyncValue', 'AsyncData', 'AsyncError', 'AsyncLoading', 'ProviderBase', 'ProviderListenable',
    'Equatable', 'LocaleKeys', 'tr', 'Icons', 'LucideIcons', 'Lucide', 'Colors', 'Theme',
    'MediaQuery', 'Navigator', 'Route', 'PageRoute', 'PageTemplate', 'ExecutionGateService',
    'KpiMetric', 'AppLayout', 'SideBar', 'NavBar', 'Footer', 'Dashboard'
}

PREFIXES = [
    'AdministrativeForms', 'ClinicalForms', 'CommonForms', 'CommonUi', 'FinancialForms',
    'CrmForms', 'HrForms', 'CorporateGovernance', 'FacilityMaintenance', 'FinanceDashboard',
    'InventoryTracking', 'MessagingHub', 'PatientCare', 'PharmacySystem', 'SchedulingPro',
    'SecurityAudit', 'TelehealthSuite', 'WoundCare', 'ClinicalIntelligence', 'DeveloperSamples',
    'Administrative', 'Clinical', 'Common', 'Financial', 'Crm', 'Hr', 'Corporate', 'Facility',
    'Finance', 'Inventory', 'Messaging', 'Patient', 'Pharmacy', 'Scheduling', 'Security',
    'Telehealth', 'Wound', 'Family', 'Franchise', 'Marketing', 'Regional', 'System',
    'Chiropractor', 'Dental', 'Massage', 'Medical', 'Nursing', 'Physiotherapist', 'Psychology',
    'Psw', 'Rn', 'Rpn', 'Scheduler', 'ClinicalDirector', 'ComplianceManager', 'IntakeCoordinator',
    'MarketingManager', 'RegionalManager', 'SharedAdmin', 'SharedFuse', 'Shared'
]

def get_mappings():
    name_map = {}
    
    # Files to scan for class/typedef definitions
    scan_files = [TARGET_FILES[0], TARGET_FILES[1]]
    
    for file_path in scan_files:
        if not os.path.exists(file_path):
            continue
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Match class/typedef names
        names = re.findall(r'\b(?:class|typedef)\s+([A-Z][a-zA-Z0-9]+)\b', content)
        
        for full_name in names:
            if full_name in BLACKLIST:
                continue
            
            for prefix in PREFIXES:
                if full_name.startswith(prefix) and len(full_name) > len(prefix):
                    short_name = full_name[len(prefix):]
                    if short_name and short_name not in BLACKLIST and len(short_name) > 3:
                        # If multiple prefixes match, we take the longest one (most specific)
                        if short_name not in name_map or len(prefix) > len(name_map[short_name].split('//')[1]):
                             name_map[short_name] = full_name + "//" + prefix # Temp storage of prefix length
    
    # Finalize map by removing temp info
    final_map = {k: v.split('//')[0] for k, v in name_map.items()}
    return final_map

def fix_file(file_path, name_map):
    if not os.path.exists(file_path):
        return 0
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    sorted_short_names = sorted(name_map.keys(), key=len, reverse=True)
    
    replacements = 0
    for short_name in sorted_short_names:
        long_name = name_map[short_name]
        if short_name == long_name:
            continue
            
        pattern = r'(?<![a-zA-Z0-9])' + re.escape(short_name) + r'(?![a-zA-Z0-9])'
        
        def replace_fn(match):
            nonlocal replacements
            replacements += 1
            return long_name
            
        content = re.sub(pattern, replace_fn, content)
        
    if content != original_content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        return replacements
    return 0

if __name__ == '__main__':
    mappings = get_mappings()
    print(f"Found {len(mappings)} prefix mappings.")
    
    for f in TARGET_FILES:
        reps = fix_file(f, mappings)
        print(f"Fixed {reps} occurrences in {f}")
