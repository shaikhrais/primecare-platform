const fs = require('fs');
const path = require('path');

const sidebarPath = path.join(__dirname, '..', 'lib', 'core', 'widgets', 'universal_role_sidebar.dart');
let sidebarCode = fs.readFileSync(sidebarPath, 'utf8');

const myRoleStr = "ResponsiveNavigationData(label: 'My Role', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),";
const dailyActivitiesStr = "ResponsiveNavigationData(label: 'Daily Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),";

// Dynamically extract any existing stray Daily Activities buttons to prevent duplicates
let cleanCode = sidebarCode.split(dailyActivitiesStr).join('');

// Structurally re-inject the Daily Activities button securely above "My Role" everywhere to normalize indices identically matching the paths mapping array.
cleanCode = cleanCode.split(myRoleStr).join(dailyActivitiesStr + '\n        ' + myRoleStr);

fs.writeFileSync(sidebarPath, cleanCode);
console.log("Sidebar strictly repaired normalizing all destination indices precisely against routing paths natively.");
