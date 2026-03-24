const fs = require('fs');
const path = require('path');

const sidebarPath = path.join(__dirname, '..', 'lib', 'core', 'widgets', 'universal_role_sidebar.dart');
const mainPath = path.join(__dirname, '..', 'lib', 'main.dart');

// 1. Patch universal_role_sidebar.dart explicitly executing iterative mapping
let sidebarCode = fs.readFileSync(sidebarPath, 'utf8');

// For admin
let adminTarget = `ResponsiveNavigationData(label: 'Daily Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),`;
let adminInject = `ResponsiveNavigationData(label: 'Global Telemetry', icon: Icons.radar_outlined, selectedIcon: Icons.radar_rounded),\n        `;
// Since 'Daily Activities' appears 9 times, we want only the one in the admin section.
// The easiest regex is to replace 'Daily Activities' right before 'My Role'... wait, it's 9 times.
// We can just find paths = ['/dashboard', '/admin/network', '/admin/audit', '/admin/settings', '/admin/activities', '/admin/mentor'];
// And replace that. But how to inject the button?
// Let's do a strict replace on the block:
let adminBlockRegex = /activeColor = const Color\(0xFF8B5CF6\);\s*destinations = \[\s*ResponsiveNavigationData\(label: 'Matrix'[\s\S]*?paths = \['\/dashboard', '\/admin\/network', '\/admin\/audit', '\/admin\/settings', '\/admin\/activities', '\/admin\/mentor'\];/;

let newAdminBlock = `activeColor = const Color(0xFF8B5CF6);
      destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.dashboard_rounded, selectedIcon: Icons.dashboard_rounded),
        ResponsiveNavigationData(label: 'Network', icon: Icons.hub_outlined, selectedIcon: Icons.hub),
        ResponsiveNavigationData(label: 'Audit', icon: Icons.security_rounded, selectedIcon: Icons.security_rounded),
        ResponsiveNavigationData(label: 'Global Telemetry', icon: Icons.radar_outlined, selectedIcon: Icons.radar_rounded),
        ResponsiveNavigationData(label: 'Settings', icon: Icons.settings_outlined, selectedIcon: Icons.settings),
        ResponsiveNavigationData(label: 'Daily Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),
        ResponsiveNavigationData(label: 'My Role', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),
      ];
      paths = ['/dashboard', '/admin/network', '/admin/audit', '/admin/telemetry', '/admin/settings', '/admin/activities', '/admin/mentor'];`;

sidebarCode = sidebarCode.replace(adminBlockRegex, newAdminBlock);
fs.writeFileSync(sidebarPath, sidebarCode);
console.log("Sidebar strictly patched with Global Telemetry exclusively for Admin natively.");

// 2. Patch main.dart globally executing integration pipelines
let mainCode = fs.readFileSync(mainPath, 'utf8');

if (!mainCode.includes("import 'features/admin/admin_telemetry_screen.dart';")) {
    mainCode = mainCode.replace(
        "import 'features/admin/admin_audit_screen.dart';",
        "import 'features/admin/admin_audit_screen.dart';\nimport 'features/admin/admin_telemetry_screen.dart';"
    );
}

const adminRouteTarget = `GoRoute(path: '/admin/audit', builder: (context, state) => AdminAuditScreen()),`;
const adminRouteInject = `GoRoute(path: '/admin/telemetry', builder: (context, state) => const AdminTelemetryScreen()),\n          `;
mainCode = mainCode.replace(adminRouteTarget, adminRouteInject + adminRouteTarget);

fs.writeFileSync(mainPath, mainCode);
console.log("main.dart execution logic strictly altered pushing the telemetry arrays natively.");
