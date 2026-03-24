const fs = require('fs');
const path = require('path');

const sidebarPath = path.join(__dirname, '..', 'lib', 'core', 'widgets', 'universal_role_sidebar.dart');
const mainPath = path.join(__dirname, '..', 'lib', 'main.dart');

// 1. Sidebar Architecture Decoupling
let sideCode = fs.readFileSync(sidebarPath, 'utf8');

sideCode = sideCode.split("label: 'Daily Activities'").join("label: 'Activities'");

const activitiesStr = "ResponsiveNavigationData(label: 'Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),";
const tasksStr = "ResponsiveNavigationData(label: 'Daily Tasks', icon: Icons.task_alt, selectedIcon: Icons.task_alt),\n        ";

sideCode = sideCode.split(activitiesStr).join(tasksStr + activitiesStr);

const roles = ['psw', 'rn', 'client', 'coordinator', 'manager', 'mt', 'gm', 'scrum-master', 'admin'];

roles.forEach(role => {
  const actPath = `'/${role}/activities'`;
  const tskPath = `'/${role}/dailyTasks', `;
  sideCode = sideCode.split(actPath).join(tskPath + actPath);
});

fs.writeFileSync(sidebarPath, sideCode);

// 2. Main Router Decoupling
let mainCode = fs.readFileSync(mainPath, 'utf8');

if (!mainCode.includes("universal_daily_tasks_screen.dart")) {
  mainCode = "import 'features/shared/universal_daily_tasks_screen.dart';\n" + mainCode;
}

// Strip out any broken aliases natively
mainCode = mainCode.replace(/GoRoute\(path: '\/[a-z\-]+\/dailyTasks'[^)]+\)\),\s*/g, '');

roles.forEach(role => {
  const actRouteStr = `GoRoute(path: '/${role}/activities'`;
  const rolePrefix = role === 'scrum-master' ? 'scrum_master' : role;
  const newRoute = `GoRoute(path: '/${role}/dailyTasks', builder: (context, state) => const UniversalDailyTasksScreen(rolePrefix: '${rolePrefix}')),\n          `;
  
  mainCode = mainCode.split(actRouteStr).join(newRoute + actRouteStr);
});

fs.writeFileSync(mainPath, mainCode);
console.log("Entire architecture securely decoupled into the 3 discrete arrays identically routing natively.");
