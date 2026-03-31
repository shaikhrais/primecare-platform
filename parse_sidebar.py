import os

source_path = os.path.join(os.path.dirname(__file__), 'sidebar_source.txt')
dart_path = os.path.join(os.path.dirname(__file__), 'apps', 'primecare_v4', 'lib', 'office', 'layouts', 'sidebar_config.dart')

role_map = {}
current_role = None

# Custom normalizer to match the API roles identically
def normalize_role(role_name):
    role_name = role_name.strip()
    if 'GLOBAL' in role_name: return 'global'
    if 'Founder' in role_name or 'CEO' in role_name: return 'CEO'
    if 'COO' in role_name: return 'COO'
    if 'CFO' in role_name: return 'CFO'
    if 'CTO' in role_name: return 'CTO'
    if 'Compliance Manager' in role_name: return 'Compliance Manager'
    if 'Head of Business Development' in role_name: return 'Head of Business Development'
    if 'Head of Marketing' in role_name: return 'Head of Marketing'
    if 'Training Director' in role_name: return 'Training Director'
    if 'Regional BDM' in role_name: return 'Regional BDM'
    if 'Franchise Sales Manager' in role_name: return 'Franchise Sales Manager'
    if 'Partnership Manager' in role_name: return 'Partnership Manager'
    if 'Territory Expansion Manager' in role_name: return 'Territory Expansion Manager'
    if 'Franchise Owner' in role_name: return 'Franchise Owner'
    if 'Operations Manager' in role_name: return 'Operations Manager'
    if 'Scheduler' in role_name: return 'Scheduler / Coordinator'
    if 'Billing' in role_name or 'Admin' in role_name: return 'Admin'
    if 'HR' in role_name or 'Hiring' in role_name: return 'HR / Hiring'
    if 'RN' in role_name: return 'RN'
    if 'RPN' in role_name: return 'RPN'
    if 'RMT' in role_name: return 'RMT'
    if 'PSW' in role_name: return 'PSW'
    if 'Customer Support' in role_name: return 'Customer Support'
    if 'Intake Coordinator' in role_name: return 'Intake Coordinator'
    if 'Quality Assurance' in role_name: return 'Quality Assurance'
    if 'Training Coordinator' in role_name: return 'Training Coordinator'
    if 'Local Marketing Manager' in role_name: return 'Local Marketing Manager'
    if 'Community Outreach' in role_name: return 'Community Outreach'
    if 'Territory Sales Manager' in role_name: return 'Territory Sales Manager'
    if 'Client' in role_name: return 'Client'
    if 'Family Member' in role_name: return 'Family Member'
    return role_name

def assign_icon(item):
    item = item.lower()
    if 'dashboard' in item: return 'Icons.dashboard'
    if 'calendar' in item or 'schedule' in item or 'appointments' in item or 'shifts' in item: return 'Icons.calendar_today'
    if 'task' in item or 'assignment' in item: return 'Icons.task_alt'
    if 'message' in item or 'chat' in item or 'communication' in item: return 'Icons.chat_bubble_outline'
    if 'notification' in item or 'alert' in item: return 'Icons.notifications_outlined'
    if 'document' in item or 'form' in item or 'contracts' in item: return 'Icons.description_outlined'
    if 'report' in item or 'analytics' in item or 'performance' in item or 'snapshot' in item or 'kpi' in item: return 'Icons.analytics_outlined'
    if 'help' in item or 'support' in item or 'ticket' in item: return 'Icons.help_outline'
    if 'setting' in item: return 'Icons.settings_outlined'
    if 'revenue' in item or 'finance' in item or 'expense' in item or 'invoice' in item or 'billing' in item or 'payment' in item or 'budget' in item: return 'Icons.attach_money'
    if 'staff' in item or 'hr' in item or 'hiring' in item or 'candidate' in item or 'applicant' in item: return 'Icons.people_alt'
    if 'client' in item or 'patient' in item or 'family' in item: return 'Icons.personal_injury'
    if 'care plan' in item or 'treatment' in item or 'note' in item or 'assessment' in item or 'vital' in item or 'soap' in item: return 'Icons.medical_services_outlined'
    if 'lead' in item or 'franchise' in item or 'deal' in item or 'prospect' in item or 'pipeline' in item: return 'Icons.business_center_outlined'
    if 'compliance' in item or 'audit' in item or 'policy' in item or 'credential' in item: return 'Icons.verified_user_outlined'
    if 'training' in item or 'course' in item or 'learn' in item or 'module' in item: return 'Icons.school_outlined'
    if 'partner' in item or 'outreach' in item or 'community' in item: return 'Icons.handshake_outlined'
    if 'map' in item or 'territory' in item or 'region' in item: return 'Icons.map_outlined'
    if 'campaign' in item or 'marketing' in item or 'conversion' in item: return 'Icons.campaign_outlined'
    
    return 'Icons.circle_outlined' # default

with open(source_path, 'r') as f:
    lines = f.readlines()

for line in lines:
    line = line.strip()
    if not line: continue
    
    if line.startswith('#'):
        current_role = normalize_role(line[1:])
        role_map[current_role] = []
    else:
        if current_role:
            role_map[current_role].append(line)

# Generate Dart output
dart_code = """import 'package:flutter/material.dart';

class SidebarItemData {
  final String label;
  final IconData icon;
  final String path;

  const SidebarItemData({
    required this.label,
    required this.icon,
    this.path = '',
  });
}

class SidebarConfig {
  static final Map<String, List<SidebarItemData>> roleMenus = {
"""

for role, items in role_map.items():
    if role == 'global': continue
    dart_code += f"    '{role}': [\n"
    for item in items:
        # Determine base route routing logically, we don't have to bind exact endpoints yet, the SPA routes internally
        icon = assign_icon(item)
        dart_code += f"      SidebarItemData(label: '{item}', icon: {icon}),\n"
    dart_code += "    ],\n"

dart_code += """  };
  
  static List<SidebarItemData> getMenuForRole(String role) {
    if (role.isEmpty) return roleMenus['PSW'] ?? []; // Default fallback
    
    // Exact mapping check
    for (String key in roleMenus.keys) {
      if (role.toLowerCase().contains(key.toLowerCase())) {
        return roleMenus[key]!;
      }
    }
    
    // Fuzzy matching fallbacks based on tokens
    if (role.toLowerCase().contains('rn')) return roleMenus['RN']!;
    if (role.toLowerCase().contains('rmt')) return roleMenus['RMT']!;
    if (role.toLowerCase().contains('physio')) return roleMenus['Physio'] ?? roleMenus['RMT']!;
    
    return roleMenus['PSW']!; 
  }
}
"""

with open(dart_path, 'w') as f:
    f.write(dart_code)

print("sidebar_config.dart generated successfully.")
