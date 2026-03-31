const fs = require('fs');
const path = require('path');

const rolesMap = {
  common: ['dashboard', 'profile', 'notifications', 'messages', 'schedule', 'documents', 'settings', 'support'],
  founder: ['executive_dashboard', 'territory_map', 'franchise_performance', 'revenue_analytics', 'growth_pipeline', 'reports_center', 'user_management'],
  franchise_owner: ['owner_dashboard', 'clients', 'staff', 'schedule', 'billing', 'reports', 'alerts'],
  operations: ['operations_dashboard', 'shift_board', 'staff_assignment', 'incident_center', 'visit_monitoring'],
  scheduler: ['calendar', 'open_shifts', 'staff_availability', 'visit_planner', 'cancellation_manager'],
  rn: ['rn_dashboard', 'care_plans', 'assigned_clients', 'vitals_review', 'risk_assessment', 'notes_review'],
  rmt: ['appointments', 'treatment_notes', 'soap_notes', 'schedule', 'client_history'],
  psw: ['psw_dashboard', 'my_shift', 'my_clients', 'daily_entry', 'adl_log', 'medication_assistance', 'vitals', 'notes', 'incident_report', 'messages'],
  support: ['support_dashboard', 'tickets', 'client_issues', 'escalations', 'knowledge_base'],
  marketing: ['marketing_dashboard', 'campaigns', 'leads', 'conversion_reports', 'outreach'],
  client: ['client_dashboard', 'appointments', 'care_plan', 'invoices', 'messages', 'profile'],
  layouts: ['master_layout', 'sidebar_layout', 'top_bar_layout']
};

const BASE_DIR = path.join(__dirname, 'lib', 'office');

function toPascalCase(str) {
  return str.split('_').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join('');
}

function getBoilerplate(role, fileBase) {
  const className = toPascalCase(fileBase);
  
  if (role === 'layouts') {
    // Generate specialized boilerplate for layouts
    if (fileBase === 'master_layout') {
      return `import 'package:flutter/material.dart';
import 'sidebar_layout.dart';
import 'top_bar_layout.dart';

class MasterLayout extends StatelessWidget {
  final Widget child;
  const MasterLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarLayout(),
      body: Row(
        children: [
          const SidebarLayout(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
`;
    }
    
    if (fileBase === 'sidebar_layout') {
      return `import 'package:flutter/material.dart';

class SidebarLayout extends StatelessWidget {
  const SidebarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).colorScheme.surface,
      child: ListView(
        children: const [
          ListTile(title: Text('Menu Item 1')),
          ListTile(title: Text('Menu Item 2')),
        ],
      ),
    );
  }
}
`;
    }

    if (fileBase === 'top_bar_layout') {
      return `import 'package:flutter/material.dart';

class TopBarLayout extends StatelessWidget implements PreferredSizeWidget {
  const TopBarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('PrimeCare Office'),
      actions: const [
        Icon(Icons.notifications),
        SizedBox(width: 16),
        Icon(Icons.person),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
`;
    }
  }

  // Standard generic screens
  return `import 'package:flutter/material.dart';
import '../../layouts/master_layout.dart';

class ${className}Screen extends StatelessWidget {
  const ${className}Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      child: Center(
        child: Text('${className} Screen', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
`;
}

Object.entries(rolesMap).forEach(([role, files]) => {
  const roleDir = role === 'layouts' ? path.join(BASE_DIR, 'layouts') : path.join(BASE_DIR, 'roles', role);
  
  if (!fs.existsSync(roleDir)) {
    fs.mkdirSync(roleDir, { recursive: true });
  }

  files.forEach(file => {
    const filePath = path.join(roleDir, \`\${file}.dart\`);
    if (!fs.existsSync(filePath)) {
      const content = getBoilerplate(role, file);
      fs.writeFileSync(filePath, content, 'utf8');
      console.log(\`Generated: \${filePath}\`);
    } else {
      console.log(\`Skipped (already exists): \${filePath}\`);
    }
  });
});

console.log('All office files have been generated successfully!');
