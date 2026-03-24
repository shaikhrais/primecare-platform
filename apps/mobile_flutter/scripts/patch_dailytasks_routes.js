const fs = require('fs');
const path = require('path');
const mainPath = path.join(__dirname, '..', 'lib', 'main.dart');

let mainCode = fs.readFileSync(mainPath, 'utf8');
const roles = ['psw', 'rn', 'client', 'coordinator', 'manager', 'mt', 'gm', 'scrum_master', 'admin'];

roles.forEach(role => {
    let pathRole = role;
    if(role === 'scrum_master') pathRole = 'scrum-master';
    
    const activityRoute = `GoRoute(path: '/${pathRole}/activities', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: '${role}')),`;
    const newRouteStr = `GoRoute(path: '/${pathRole}/dailyTasks', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: '${role}')),`;
    
    if (mainCode.includes(activityRoute) && !mainCode.includes(`'/${pathRole}/dailyTasks'`)) {
        mainCode = mainCode.replace(activityRoute, activityRoute + '\n          ' + newRouteStr);
    }
});

fs.writeFileSync(mainPath, mainCode);
console.log("main.dart explicitly patched mapping the dailyTasks alias loop globally!");
