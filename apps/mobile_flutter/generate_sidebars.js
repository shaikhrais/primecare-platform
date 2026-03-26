const fs = require('fs');
const path = require('path');

const roles = {
  psw: {
    color: '0xFF10B981',
    paths: ['/psw/home', '/psw/timesheets', '/psw/earnings', '/universal/psw/inbox', '/universal/sow'],
    items: [
      "{ icon: Icon(Icons.home), label: 'Home' }",
      "{ icon: Icon(Icons.schedule_send), label: 'Timesheet' }",
      "{ icon: Icon(Icons.account_balance), label: 'Earnings' }",
      "{ icon: Icon(Icons.chat), label: 'Inbox' }",
      "{ icon: Icon(Icons.checklist), label: 'My List' }"
    ]
  },
  rn: {
    color: '0xFF3B82F6',
    paths: ['/rn/home', '/rn/care-plan', '/universal/rn/inbox', '/universal/sow'],
    items: [
      "{ icon: Icon(Icons.people), label: 'Patients' }",
      "{ icon: Icon(Icons.edit_document), label: 'Plan' }",
      "{ icon: Icon(Icons.inbox), label: 'Inbox' }",
      "{ icon: Icon(Icons.checklist), label: 'My List' }"
    ]
  },
  coordinator: {
    color: '0xFFF59E0B',
    paths: ['/coordinator/home', '/coordinator/approvals', '/coordinator/callin', '/coordinator/visit-adjust', '/universal/coordinator/inbox', '/universal/sow'],
    items: [
      "{ icon: Icon(Icons.grid_view), label: 'Hub' }",
      "{ icon: Icon(Icons.fact_check), label: 'Approvals' }",
      "{ icon: Icon(Icons.phone_disabled), label: 'Call-in' }",
      "{ icon: Icon(Icons.edit_calendar), label: 'Adjust' }",
      "{ icon: Icon(Icons.chat), label: 'Inbox' }",
      "{ icon: Icon(Icons.checklist), label: 'My List' }"
    ]
  },
  manager: {
    color: '0xFFF43F5E',
    paths: ['/manager/home', '/manager/teams', '/manager/payroll', '/manager/incidents', '/universal/manager/inbox', '/universal/sow'],
    items: [
      "{ icon: Icon(Icons.bar_chart), label: 'Reports' }",
      "{ icon: Icon(Icons.people), label: 'Teams' }",
      "{ icon: Icon(Icons.payments), label: 'Payroll' }",
      "{ icon: Icon(Icons.warning), label: 'Escalations' }",
      "{ icon: Icon(Icons.chat), label: 'Inbox' }",
      "{ icon: Icon(Icons.checklist), label: 'My List' }"
    ]
  },
  admin: {
    color: '0xFF8B5CF6',
    paths: ['/admin/home', '/admin/audit', '/universal/admin/inbox', '/universal/sow'],
    items: [
      "{ icon: Icon(Icons.radar), label: 'Telemetry' }",
      "{ icon: Icon(Icons.security), label: 'Shadows' }",
      "{ icon: Icon(Icons.chat), label: 'Inbox' }",
      "{ icon: Icon(Icons.checklist), label: 'My List' }"
    ]
  },
  client: {
    color: '0xFF0EA5E9',
    paths: ['/client/home', '/client/pulse', '/client/dispatch', '/client/payments', '/universal/client/inbox'],
    items: [
      "{ icon: Icon(Icons.people), label: 'Team' }",
      "{ icon: Icon(Icons.monitor_heart), label: 'Pulse' }",
      "{ icon: Icon(Icons.map), label: 'Tracker' }",
      "{ icon: Icon(Icons.credit_card), label: 'Billing' }",
      "{ icon: Icon(Icons.chat), label: 'Inbox' }"
    ]
  },
  gm: {
    color: '0xFF6366F1',
    paths: ['/gm_home', '/gm/pnl', '/universal/gm/inbox', '/universal/sow'],
    items: [
      "{ icon: Icon(Icons.dashboard), label: 'Executive' }",
      "{ icon: Icon(Icons.stacked_line_chart), label: 'Ledger' }",
      "{ icon: Icon(Icons.chat), label: 'Comm' }",
      "{ icon: Icon(Icons.checklist), label: 'My List' }"
    ]
  },
  mt: {
    color: '0xFFF97316',
    paths: ['/mt/home', '/mt/surge-config', '/universal/mt/inbox', '/universal/sow'],
    items: [
      "{ icon: Icon(Icons.analytics), label: 'Analytics' }",
      "{ icon: Icon(Icons.offline_bolt), label: 'Surge' }",
      "{ icon: Icon(Icons.chat), label: 'Inbox' }",
      "{ icon: Icon(Icons.checklist), label: 'My List' }"
    ]
  },
  superuser: {
    color: '0xFFEF4444',
    paths: ['/superuser/home', '/superuser/territory', '/superuser/registry', '/universal/sow'],
    items: [
      "{ icon: Icon(Icons.home), label: 'Root' }",
      "{ icon: Icon(Icons.map), label: 'Territories' }",
      "{ icon: Icon(Icons.sync_problem), label: 'Registry' }",
      "{ icon: Icon(Icons.checklist), label: 'My List' }"
    ]
  }
};

const baseDir = 'c:\\\\Users\\\\Admin2\\\\Documents\\\\GitHub\\\\primecare-platform\\\\apps\\\\mobile_flutter\\\\lib\\\\features\\\\roles';

for (const [role, data] of Object.entries(roles)) {
  const dirPath = path.join(baseDir, role);
  if (!fs.existsSync(dirPath)) fs.mkdirSync(dirPath, { recursive: true });
  
  const fileContent = \`import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final \${role}SidebarConfig = SidebarConfig(
  activeColor: const Color(\${data.color}),
  paths: [\${data.paths.map(p => \`'\${p}'\`).join(', ')}],
  items: const [
    \${data.items.map(i => \`BottomNavigationBarItem\${i}\`).join(',\\n    ')}
  ],
);
\`;
  fs.writeFileSync(path.join(dirPath, \`\${role}_sidebar_config.dart\`), fileContent);
}

const thinHubDir = 'c:\\\\Users\\\\Admin2\\\\Documents\\\\GitHub\\\\primecare-platform\\\\apps\\\\mobile_flutter\\\\lib\\\\features\\\\master\\\\shared';
if (!fs.existsSync(thinHubDir)) fs.mkdirSync(thinHubDir, { recursive: true });
const thinHubContent = \`import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

final thinHubSidebarConfig = SidebarConfig(
  activeColor: Colors.grey,
  paths: ['/thin-hub'],
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.hub), label: 'Hub'),
  ],
);
\`;
fs.writeFileSync(path.join(thinHubDir, \`thin_hub_sidebar_config.dart\`), thinHubContent);

console.log('Sidebar decouple script completed.');
