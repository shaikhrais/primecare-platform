import os
import sys
import sqlite3
import re

# Add current folder to path to import governance_db
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import governance_db

def generate():
    registry_path = 'packages/flutter_core/lib/config/navigation_registry.dart'
    if not os.path.exists(registry_path):
        print(f"Error: {registry_path} does not exist")
        sys.exit(1)
        
    with open(registry_path, 'r', encoding='utf-8') as f:
        content = f.read()
        
    # 1. Parse all original menus and build master catalog + index original items per role
    role_menus_match = re.search(r'static final Map<String, List<PrimeCareNavigationItem>> _roleMenus = \{(.*?)\};', content, re.DOTALL)
    if not role_menus_match:
        print("Error: Could not find _roleMenus map in existing registry")
        sys.exit(1)
        
    role_menus_str = role_menus_match.group(1)
    role_blocks = re.findall(r"'(.*?)':\s*\[(.*?)\]", role_menus_str, re.DOTALL)
    
    master_catalog = {}
    original_role_items = {}
    
    for role, block in role_blocks:
        items = re.findall(r"const PrimeCareNavigationItem\(\s*label:\s*['\"](.*?)['\"],\s*icon:\s*(.*?),\s*route:\s*(.*?),\s*section:\s*['\"](.*?)['\"],?\s*\)", block, re.DOTALL)
        original_role_items[role] = []
        for label, icon, route, section in items:
            item_info = {
                'label': label,
                'icon': icon.strip(),
                'route': route.strip(),
                'section': section.strip()
            }
            master_catalog[label] = item_info
            original_role_items[role].append(item_info)
            
    print(f"Parsed {len(original_role_items)} roles and {len(master_catalog)} master catalog entries.")
    
    # 2. Connect to database
    conn = governance_db.get_connection()
    cursor = conn.cursor()
    
    # Map Dart role keys to DB role_codes
    role_mapping = {
        'Admin': 'admin',
        'CEO': 'ceo',
        'Compliance Manager': 'compliance',
        'Customer Support': 'portal',
        'CFO': 'cfo',
        'COO': 'coo',
        'CTO': 'cto',
        'Corporate Developer': 'system_verification',
        'Training Director': 'training_director',
        'Regional Manager': 'regional_manager_usa',
        'Finance Director': 'finance_director',
        'Intake Coordinator': 'intake',
        'Billing Admin': 'scheduler',
        'Marketing Manager': 'local_marketing',
        'Franchise Owner': 'owner',
        'PSW': 'psw',
        'Client': 'patient',
        'Head of Marketing': 'marketing',
        'Head of Business Development': 'bus_dev',
        'Operations Manager': 'ops_manager',
        'HR Hiring': 'hr_hiring',
        'Clinical Director': 'clinical_director',
        'Shareholder': 'shareholder',
        'Therapist': 'therapist',
        'Physician': 'physician',
        'Clinical Nurse Specialist': 'cns',
        'Pediatric Specialist': 'pediatric',
        'Caregiver': 'caregiver',
        'Premium Concierge': 'premium_concierge',
        'VIP Client Manager': 'vip_manager',
        'RN Field Supervisor': 'rn_field_supervisor',
        'Nurse Practitioner': 'np',
        'LPN': 'lpn',
        'Employee': 'employee',
        'Volunteer': 'volunteer',
        'HSW': 'hsw',
    }
    
    # Direct mapping from screen_code to translatable label key
    screen_to_label_mapping = {
        'ceo_dashboard_controller': 'navigation.items.system_dashboard',
        'admin_dashboard_controller': 'navigation.items.system_dashboard',
        'compliance_manager_dashboard_controller': 'navigation.items.compliance_hub',
        'clinical_dashboard_controller': 'navigation.items.clinical_dashboard',
        'clinic_dashboard_controller': 'navigation.items.clinical_dashboard',
        'patient_dashboard_controller': 'navigation.items.family_home',
        'family_member_dashboard_controller': 'navigation.items.family_home',
        'finance_director_dashboard_controller': 'navigation.items.ledger_command',
        'scheduler_dashboard_controller': 'navigation.items.billing_console',
        'billing_admin_dashboard_controller': 'navigation.items.billing_console',
        'local_marketing_manager_dashboard_controller': 'navigation.items.marketing_hub',
        'owner_dashboard_controller': 'navigation.items.business_overview',
        'franchise_dashboard_controller': 'navigation.items.business_overview',
        'receptionist_dashboard_controller': 'navigation.items.receptionist_dashboard',
        'hr_manager_dashboard_controller': 'navigation.items.hr_manager_dashboard',
        'quality_assurance_dashboard_controller': 'navigation.items.platform_usage',
        'course_architect_dashboard_controller': 'navigation.items.curriculum_hub',
        'training_director_dashboard_controller': 'navigation.items.curriculum_hub',
        'head_of_bus_dev_dashboard_controller': 'navigation.items.head_of_bus_dev_dashboard',
        'head_of_marketing_dashboard_controller': 'navigation.items.head_of_marketing_dashboard',
    }
    
    # Rebuild roleMenus strictly based on DB can_view permissions
    new_role_menus = {}
    
    for dart_role, db_code in role_mapping.items():
        # Get authorized screen codes for this role
        cursor.execute("""
        SELECT s.screen_code, s.screen_name, s.route_path
        FROM role_screen_permissions rsp
        JOIN roles r ON rsp.role_id = r.id
        JOIN screens s ON rsp.screen_id = s.id
        WHERE r.role_code = ? AND rsp.can_view = 1
        """, (db_code,))
        authorized_screens = [row['screen_code'] for row in cursor.fetchall()]
        
        # Build list of navigation items
        role_items = []
        seen_labels = set()
        
        # 1. Look through original items for this role, keep them if their corresponding screen is authorized
        # Or if they are common tools (settings, messages, vault, notifications)
        original_items = original_role_items.get(dart_role, [])
        for item in original_items:
            label = item['label']
            is_common = any(keyword in label for keyword in ['global_settings', 'messaging_hub', 'document_vault', 'notification_center', 'messages'])
            
            # Find which screen code this item maps to
            associated_screen = None
            for sc, lb in screen_to_label_mapping.items():
                if lb == label:
                    associated_screen = sc
                    break
            if not associated_screen:
                # Deduce screen code from label
                base = label.replace('navigation.items.', '')
                associated_screen = f"{base}_dashboard_controller"
            
            # Keep if common or authorized
            if is_common or associated_screen in authorized_screens:
                if label not in seen_labels:
                    role_items.append(item)
                    seen_labels.add(label)
                    
        # 2. Add any authorized DB screens that were NOT in the original items list!
        for sc in authorized_screens:
            label = screen_to_label_mapping.get(sc)
            if not label:
                base = sc.replace('_dashboard_controller', '').replace('_controller', '')
                label = f"navigation.items.{base}"
                
            if label not in seen_labels:
                # Find in master catalog
                catalog_item = master_catalog.get(label)
                if catalog_item:
                    role_items.append(catalog_item)
                else:
                    # Dynamically generate sensible defaults
                    # Determine route path/var
                    cursor.execute("SELECT route_path, screen_name FROM screens WHERE screen_code = ?", (sc,))
                    s_row = cursor.fetchone()
                    if s_row:
                        route_path = s_row['route_path']
                        # E.g. /offices/corporate/roles/ceo/dashboard
                        clean_name = sc.replace('_dashboard_controller', '').replace('_controller', '').replace('_', '-')
                        dyn_route = f"'/offices/common/roles/{db_code}/{clean_name}'"
                    else:
                        dyn_route = f"'/offices/common/roles/{db_code}/dashboard'"
                        
                    dyn_item = {
                        'label': label,
                        'icon': 'LucideIcons.layoutDashboard',
                        'route': dyn_route,
                        'section': 'navigation.sections.navigation.sections.main'
                    }
                    role_items.append(dyn_item)
                seen_labels.add(label)
                
        new_role_menus[dart_role] = role_items

    # 3. Generate the Dart code
    rep = []
    rep.append('// ignore_for_file: unused_import')
    rep.append('// Layer: 01_INFRASTRUCTURE')
    rep.append('// GENERATED CODE - DO NOT MODIFY BY HAND')
    rep.append('// This file is generated by .agents/governance/manifest_generator.py from SQLite DB')
    rep.append('// Source: .agents/governance/governance.db (role_screen_permissions table)')
    rep.append('')
    rep.append("import 'package:lucide_icons/lucide_icons.dart';")
    rep.append("import '../models/navigation_item.dart';")
    rep.append("import '../routes/groups/corporate_routes.dart';")
    rep.append("import '../routes/groups/franchise_routes.dart';")
    rep.append("import '../routes/groups/clinical_routes.dart';")
    rep.append("import '../routes/groups/client_routes.dart';")
    rep.append("import '../routes/groups/common_routes.dart';")
    rep.append('')
    rep.append('class NavigationRegistry {')
    rep.append('  static final Map<String, List<PrimeCareNavigationItem>> _roleMenus = {')

    for role in sorted(new_role_menus.keys()):
        items = new_role_menus[role]
        rep.append(f"    '{role}': [")
        for item in items:
            rep.append('      const PrimeCareNavigationItem(')
            rep.append(f"        label: '{item['label']}',")
            rep.append(f"        icon: {item['icon']},")
            rep.append(f"        route: {item['route']},")
            rep.append(f"        section: '{item['section']}',")
            rep.append('      ),')
        rep.append('    ],')

    rep.append('  };')
    rep.append('')
    rep.append("""  static List<PrimeCareNavigationItem> getMenuForRole(String role) {
    // 1. Super Admin / Admin master directory fallback
    final checkRole = role.toLowerCase();
    if (checkRole == 'super admin' ||
        checkRole == 'admin' ||
        checkRole == 'it admin') {
      final Map<String, PrimeCareNavigationItem> allItems = {};
      _roleMenus.forEach((roleName, menuList) {
        for (final item in menuList) {
          if (!allItems.containsKey(item.route)) {
            allItems[item.route] = PrimeCareNavigationItem(
              label: item.label,
              icon: item.icon,
              route: item.route,
              section: item.section ?? 'Master Directory',
              activeIcon: item.activeIcon,
            );
          }
        }
      });
      return allItems.values.toList();
    }

    // 2. Try exact match first
    if (_roleMenus.containsKey(role)) {
      return _roleMenus[role]!;
    }

    // 3. Try case-insensitive exact match
    final upperRole = role.toUpperCase();
    for (var key in _roleMenus.keys) {
      if (key.toUpperCase() == upperRole) {
        return _roleMenus[key]!;
      }
    }

    // 4. Fallback to Title Case normalization
    final normalizedRole = role
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');

    return _roleMenus[normalizedRole] ?? _roleMenus['Admin'] ?? [];
  }
}""")

    os.makedirs(os.path.dirname(registry_path), exist_ok=True)
    with open(registry_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(rep))
        
    conn.close()
    print(f"[OK] Successfully generated navigation_registry.dart with {len(new_role_menus)} roles strictly from SQLite relational tables!")

if __name__ == "__main__":
    generate()
