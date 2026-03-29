const fs = require('fs');
const path = require('path');

const rolesDir = path.join(__dirname, 'lib/features/roles');

const injections = {
  'psw_home_screen.dart': `
const SizedBox(height: 24),
PrimeCareQuickActionsGrid(
  sectionTitle: "My Day-to-Day Tasks",
  actions: [
    PrimeCareActionItem(title: 'Timesheets', icon: Icons.timer, route: AppRoutes.pswTimesheets, color: Color(0xFF1E88E5)),
    PrimeCareActionItem(title: 'Earnings', icon: Icons.attach_money, route: AppRoutes.pswEarnings, color: Colors.green),
    PrimeCareActionItem(title: 'Secure Inbox', icon: Icons.mail, route: AppRoutes.pswInbox, color: Colors.blueGrey),
    PrimeCareActionItem(title: 'SOW Metrics', icon: Icons.analytics, route: AppRoutes.pswSow, color: Colors.purple),
  ]
),
`,
  'rn_dashboard_screen.dart': `
const SizedBox(height: 24),
PrimeCareQuickActionsGrid(
  sectionTitle: "Clinical Workflow",
  actions: [
    PrimeCareActionItem(title: 'Care Plans', icon: Icons.medical_services, route: AppRoutes.rnCarePlan, color: Color(0xFF1E88E5)),
    PrimeCareActionItem(title: 'RN Inbox', icon: Icons.mail, route: AppRoutes.rnInbox, color: Colors.blueGrey),
    PrimeCareActionItem(title: 'Clinical SOW', icon: Icons.analytics, route: AppRoutes.rnSow, color: Colors.teal),
  ]
),
`,
  'coordinator_hub_screen.dart': `
const SizedBox(height: 24),
PrimeCareQuickActionsGrid(
  sectionTitle: "Coordination Tools",
  actions: [
    PrimeCareActionItem(title: 'Shift Approvals', icon: Icons.check_circle, route: AppRoutes.coordinatorApprovals, color: Colors.green),
    PrimeCareActionItem(title: 'On-Call Mgmt', icon: Icons.phone_in_talk, route: AppRoutes.coordinatorCallin, color: Colors.orange),
    PrimeCareActionItem(title: 'Visit Adjustment', icon: Icons.edit_calendar, route: AppRoutes.coordinatorVisitAdjust, color: Color(0xFF1E88E5)),
    PrimeCareActionItem(title: 'Coordinator Inbox', icon: Icons.mail, route: AppRoutes.coordinatorInbox, color: Colors.blueGrey),
  ]
),
`,
  'manager_home_screen.dart': `
const SizedBox(height: 24),
PrimeCareQuickActionsGrid(
  sectionTitle: "Management Suite",
  actions: [
    PrimeCareActionItem(title: 'Team Directory', icon: Icons.groups, route: AppRoutes.managerTeams, color: Color(0xFF1E88E5)),
    PrimeCareActionItem(title: 'Payroll Auth', icon: Icons.payments, route: AppRoutes.managerPayroll, color: Colors.green),
    PrimeCareActionItem(title: 'Incident Reports', icon: Icons.warning, route: AppRoutes.managerIncidents, color: Colors.redAccent),
    PrimeCareActionItem(title: 'Manager Inbox', icon: Icons.mail, route: AppRoutes.managerInbox, color: Colors.blueGrey),
  ]
),
`,
  'admin_home_screen.dart': `
const SizedBox(height: 24),
PrimeCareQuickActionsGrid(
  sectionTitle: "Global Administration",
  actions: [
    PrimeCareActionItem(title: 'Role Matrix', icon: Icons.admin_panel_settings, route: AppRoutes.adminRoles, color: Color(0xFF1E88E5)),
    PrimeCareActionItem(title: 'System Audit', icon: Icons.policy, route: AppRoutes.adminAudit, color: Colors.indigo),
    PrimeCareActionItem(title: 'Telemetry', icon: Icons.speed, route: AppRoutes.adminTelemetry, color: Colors.blueGrey),
    PrimeCareActionItem(title: 'Form Builder', icon: Icons.dynamic_form, route: AppRoutes.adminForms, color: Colors.orange),
  ]
),
`,
  'client_side_dashboard_screen.dart': `
const SizedBox(height: 24),
PrimeCareQuickActionsGrid(
  sectionTitle: "Client Self-Serve",
  actions: [
    PrimeCareActionItem(title: 'Client Pulse', icon: Icons.favorite, route: AppRoutes.clientPulse, color: Colors.redAccent),
    PrimeCareActionItem(title: 'Care Dispatch', icon: Icons.fire_truck, route: AppRoutes.clientDispatch, color: Color(0xFF1E88E5)),
    PrimeCareActionItem(title: 'Payments', icon: Icons.payment, route: AppRoutes.clientPayments, color: Colors.green),
    PrimeCareActionItem(title: 'Messages', icon: Icons.mail, route: AppRoutes.clientInbox, color: Colors.blueGrey),
  ]
),
`,
  'gm_executive_dashboard_screen.dart': `
const SizedBox(height: 24),
PrimeCareQuickActionsGrid(
  sectionTitle: "Executive Reporting",
  actions: [
    PrimeCareActionItem(title: 'P&L Sheets', icon: Icons.request_quote, route: AppRoutes.gmPnl, color: Colors.green),
    PrimeCareActionItem(title: 'SOW Overviews', icon: Icons.analytics, route: AppRoutes.gmSow, color: Color(0xFF1E88E5)),
    PrimeCareActionItem(title: 'GM Inbox', icon: Icons.mail, route: AppRoutes.gmInbox, color: Colors.blueGrey),
  ]
),
`,
  'superuser_dashboard_screen.dart': `
const SizedBox(height: 24),
PrimeCareQuickActionsGrid(
  sectionTitle: "Platform Superuser",
  actions: [
    PrimeCareActionItem(title: 'Territory Config', icon: Icons.map, route: AppRoutes.superuserTerritory, color: Color(0xFF1E88E5)),
    PrimeCareActionItem(title: 'Core Registry', icon: Icons.dataset, route: AppRoutes.superuserRegistry, color: Colors.indigo),
    PrimeCareActionItem(title: 'Global SOW', icon: Icons.analytics, route: AppRoutes.superuserSow, color: Colors.blueGrey),
  ]
),
`,
  'mt_home_screen.dart': `
const SizedBox(height: 24),
PrimeCareQuickActionsGrid(
  sectionTitle: "Master Terminal",
  actions: [
    PrimeCareActionItem(title: 'Surge Configurator', icon: Icons.electric_bolt, route: AppRoutes.mtSurgeConfig, color: Colors.orange),
    PrimeCareActionItem(title: 'MT Inbox', icon: Icons.mail, route: AppRoutes.mtInbox, color: Colors.blueGrey),
    PrimeCareActionItem(title: 'MT SOW', icon: Icons.analytics, route: AppRoutes.mtSow, color: Color(0xFF1E88E5)),
  ]
),
`
};

function findDartFiles(dir, fileList = []) {
  if (!fs.existsSync(dir)) return fileList;
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      findDartFiles(filePath, fileList);
    } else {
      fileList.push(filePath);
    }
  }
  return fileList;
}

const allFiles = findDartFiles(rolesDir);
let patchedCount = 0;

for (const filePath of allFiles) {
  const fileName = path.basename(filePath);
  if (injections[fileName]) {
    let content = fs.readFileSync(filePath, 'utf8');

    // Ensure AppRoutes is imported
    if (!content.includes('package:primecare_mobile/core/routing/app_routes.dart')) {
      content = content.replace(/(import 'package:flutter\/material\.dart';)/, "$1\nimport 'package:primecare_mobile/core/routing/app_routes.dart';");
    }

    // We inject the Quick Actions safely into the layout.
    // Most dashboards have a Column with a known greeting or header text like `Text('Welcome...` or a `GreetingHeaderWidget`
    // Or they are PageTemplates. If we can't find a universal insertion point, we inject just after the first Row or Greeting block inside `children: [` 

    let injection = injections[fileName];

    // Attempt to inject specifically where it makes the most sense visually without breaking brackets
    if (content.includes('child: Column(')) {
      // Find the first `children: [` and insert right after
      content = content.replace(/(child:\s*Column\s*\([\s\S]*?children:\s*\[)/, `$1\n${injection}`);
      
      fs.writeFileSync(filePath, content, 'utf8');
      patchedCount++;
      console.log('Patched Layout:', fileName);
    } else if (content.includes('PageTemplate(')) {
       // It's a PageTemplate, we can inject into the `children: [`
       content = content.replace(/(children:\s*\[)/, `$1\n${injection}`);
       fs.writeFileSync(filePath, content, 'utf8');
       patchedCount++;
       console.log('Patched PageTemplate:', fileName);
    } else {
       console.log('Could not find injection point for:', fileName);
    }
  }
}

console.log(`Successfully wired ${patchedCount} role dashboards with drill-down routes.`);
