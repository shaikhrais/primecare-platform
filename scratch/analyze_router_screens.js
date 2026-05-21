const fs = require('fs');
const path = require('path');

const appsDir = 'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\apps';
const apps = fs.readdirSync(appsDir).filter(name => fs.statSync(path.join(appsDir, name)).isDirectory());

const dashboardFilesMap = {};

apps.forEach(app => {
  const routerPath = path.join(appsDir, app, 'lib', 'core', 'routing', 'app_router.dart');
  if (fs.existsSync(routerPath)) {
    const content = fs.readFileSync(routerPath, 'utf8');
    const imports = content.split('\n').filter(line => line.includes('import ') && line.includes('dashboard_screen.dart'));
    dashboardFilesMap[app] = imports.map(line => {
      const match = line.match(/import\s+['"]([^'"]+)['"]/);
      if (match) {
        let importPath = match[1];
        if (importPath.startsWith('package:')) {
          return importPath;
        }
        const absolute = path.resolve(path.dirname(routerPath), importPath);
        return absolute;
      }
      return null;
    }).filter(Boolean);
  }
});

fs.writeFileSync('c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\scratch\\active_dashboards.json', JSON.stringify(dashboardFilesMap, null, 2));
console.log('Successfully saved to active_dashboards.json!');
