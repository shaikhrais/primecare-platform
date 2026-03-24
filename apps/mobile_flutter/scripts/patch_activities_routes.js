const fs = require('fs');
const path = require('path');

const sidebarPath = path.join(__dirname, '..', 'lib', 'core', 'widgets', 'universal_role_sidebar.dart');
const mainPath = path.join(__dirname, '..', 'lib', 'main.dart');

// 1. Patch universal_role_sidebar.dart explicitly executing iterative mapping
let sidebarCode = fs.readFileSync(sidebarPath, 'utf8');
const roles = ['psw', 'rn', 'client', 'coordinator', 'manager', 'mt', 'gm', 'scrum_master', 'admin'];

roles.forEach(role => {
    // Inject precisely structured new button locally utilizing Regex/Replace sequentially
    const mentorLabelStr = "ResponsiveNavigationData(label: 'Role Compass', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),";
    const newActivityBtn = "ResponsiveNavigationData(label: 'Daily Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),\n          ";
    
    sidebarCode = sidebarCode.replace(mentorLabelStr, newActivityBtn + mentorLabelStr);

    let pathRole = role;
    if (role === 'scrum_master') pathRole = 'scrum-master';
    
    const pathStr = `\'/${pathRole}/mentor\'`;
    const newPathStr = `\'/${pathRole}/activities\', `;
    sidebarCode = sidebarCode.replace(pathStr, newPathStr + pathStr);
});

fs.writeFileSync(sidebarPath, sidebarCode);
console.log("Sidebar accurately patched wrapping the Universal Daily Activities routing statically.");

// 2. Patch main.dart globally executing integration pipelines
let mainCode = fs.readFileSync(mainPath, 'utf8');

if (!mainCode.includes("import 'features/shared/universal_timeline_screen.dart';")) {
    mainCode = mainCode.replace(
        "import 'features/shared/role_mentor_screen.dart';",
        "import 'features/shared/role_mentor_screen.dart';\nimport 'features/shared/universal_timeline_screen.dart';"
    );
}

roles.forEach(role => {
    let pathRole = role;
    if(role === 'scrum_master') pathRole = 'scrum-master';
    const mentorRouteStr = `GoRoute(path: '/${pathRole}/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: '${role}')),`;
    const newRouteStr = `GoRoute(path: '/${pathRole}/activities', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: '${role}')),\n          `;
    
    if (mainCode.includes(mentorRouteStr)) {
        mainCode = mainCode.replace(mentorRouteStr, newRouteStr + mentorRouteStr);
    }
});

fs.writeFileSync(mainPath, mainCode);
console.log("main.dart execution logic strictly altered pushing the full array mappings natively.");
