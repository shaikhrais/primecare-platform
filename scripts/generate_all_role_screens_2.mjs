import fs from 'fs';
import path from 'path';

const basePath = path.join(process.cwd(), 'apps', 'primecare_v4', 'lib');
const sidebarConfigPath = path.join(basePath, 'office', 'layouts', 'sidebar_config.dart');
const appRoutesPath = path.join(basePath, 'routes', 'app_routes.dart');
const appRouterPath = path.join(basePath, 'routes', 'app_router.dart');
const sidebarLayoutPath = path.join(basePath, 'office', 'layouts', 'sidebar_layout.dart');

const globalScreens = ['dashboard', 'settings', 'documents', 'messages', 'notifications', 'chat'];

function parseSidebarConfig() {
  const content = fs.readFileSync(sidebarConfigPath, 'utf8');
  const roles = {};
  
  // Basic regex to find each role section
  const lines = content.split('\n');
  let currentRole = null;
  
  for (let line of lines) {
    line = line.trim();
    if (line.startsWith("'") && line.includes("': [")) {
      currentRole = line.split("'")[1];
      roles[currentRole] = [];
    } else if (currentRole && line.includes("SidebarItemData(label:")) {
      const match = line.match(/label:\s*'([^']+)'/);
      if (match) {
        roles[currentRole].push(match[1]);
      }
    } else if (currentRole && line === '],') {
      currentRole = null;
    }
  }
  return roles;
}

function normalizeRoleSlug(roleName) {
  return roleName.toLowerCase()
    .replace(/ \/ /g, '_')
    .replace(/\//g, '_')
    .replace(/ /g, '_')
    .replace(/-/g, '_');
}

function normalizeScreenSlug(screenName) {
  return screenName.toLowerCase()
    .replace(/’/g, '')
    .replace(/'/g, '')
    .replace(/ \/ /g, '_')
    .replace(/\//g, '_')
    .replace(/ /g, '_')
    .replace(/&/g, 'and')
    .replace(/-/g, '_');
}

function toCamelCase(str) {
  return str.replace(/_([a-z])/g, function(g) { return g[1].toUpperCase(); });
}

function toPascalCase(str) {
  const camel = toCamelCase(str);
  return camel.charAt(0).toUpperCase() + camel.slice(1);
}

const roleToOfficeMap = {
  'ceo': 'corporate',
  'coo': 'corporate',
  'cfo': 'corporate',
  'cto': 'corporate',
  'compliance_manager': 'corporate',
  'head_of_bus_dev': 'corporate',
  'training_director': 'corporate',
  'head_of_marketing': 'marketing',
  'regional_bdm': 'business_development',
  'franchise_sales_manager': 'business_development',
  'partnership_manager': 'business_development',
  'territory_expansion_manager': 'business_development',
  'franchise_owner': 'franchise',
  'operations_manager': 'franchise',
  'scheduler_coordinator': 'franchise',
  'admin': 'franchise', // Assuming admin goes here based on role structure
  'hr_hiring': 'franchise',
  'rn': 'clinic',
  'rpn': 'clinic',
  'rmt': 'clinic',
  'psw': 'clinic',
  'physio': 'clinic',
  'chiro': 'clinic',
  'occupational_therapist': 'clinic',
  'speech_pathologist': 'clinic',
  'customer_support': 'support',
  'intake_coordinator': 'support',
  'quality_assurance': 'support',
  'training_coordinator': 'support',
  'local_marketing_manager': 'marketing',
  'community_outreach': 'marketing',
  'territory_sales_manager': 'marketing',
  'client': 'client',
  'family_member': 'client',
  'guest': 'system',
  'scrum_master': 'system'
};

function generateScreenFile(dir, screenSlug, className) {
  const filePath = path.join(dir, `${screenSlug}.dart`);
  if (!fs.existsSync(filePath)) {
    const template = `import 'package:flutter/material.dart';
import '../../../../components/generic_feature_screen.dart';

class ${className} extends StatelessWidget {
  const ${className}({super.key});

  @override
  Widget build(BuildContext context) {
    return const GenericFeatureScreen(featureId: '${className}');
  }
}
`;
    fs.mkdirSync(dir, { recursive: true });
    fs.writeFileSync(filePath, template);
    console.log(`Generated ${filePath}`);
    return true;
  }
  return false;
}

function main() {
  const roles = parseSidebarConfig();
  let generatedScreensCount = 0;
  
  let appRoutesAdditions = [];
  let appRouterImports = [];
  let appRouterRoutes = [];
  let sidebarLayoutMappings = [];

  for (const [roleName, screens] of Object.entries(roles)) {
    const roleSlug = normalizeRoleSlug(roleName);
    
    // Some roles might not have an exact map, fallback to generic
    const office = roleToOfficeMap[roleSlug] || 'clinic';
    const roleDir = path.join(basePath, 'offices', office, 'roles', roleSlug);

    let roleRouteCode = `            } else if (role.toLowerCase() == '${roleName.toLowerCase()}') {\n              final label = item.label.toLowerCase();\n`;

    for (const screenName of screens) {
      if (globalScreens.includes(screenName.toLowerCase())) {
        continue; // Handled by global routing
      }

      const screenSlug = normalizeScreenSlug(screenName);
      const className = toPascalCase(screenSlug) + 'Screen';
      
      if (roleSlug !== 'psw') { // PSW is already done
        const generated = generateScreenFile(roleDir, screenSlug, className);
        if (generated) generatedScreensCount++;

        // Add to routes mapping
        const routeConstantName = toCamelCase(`${roleSlug}_${screenSlug}`);
        const routePath = `/offices/${office}/roles/${roleSlug}/${screenSlug.replace(/_/g, '-')}`;
        appRoutesAdditions.push(`  static const String ${routeConstantName} = '${routePath}';`);

        // Add to router imports
        const asAlias = `${roleSlug}_${screenSlug}`;
        appRouterImports.push(`import '../offices/${office}/roles/${roleSlug}/${screenSlug}.dart' as ${asAlias};`);

        // Add to router GoRoute
        appRouterRoutes.push(`        GoRoute(
          path: AppRoutes.${routeConstantName},
          builder: (context, state) => const ${asAlias}.${className}(),
        ),`);
      }

      // Add to sidebar mapping
      const routeConstantRef = `AppRoutes.${toCamelCase(`${roleSlug}_${screenSlug}`)}`;
      roleRouteCode += `              if (label.contains('${screenName.toLowerCase().replace(/'|’/g, '')}')) targetRoute = ${routeConstantRef};\n`;
    }
    roleRouteCode += `            }`;
    sidebarLayoutMappings.push(roleRouteCode);
  }

  fs.writeFileSync('scripts/mappings.txt', sidebarLayoutMappings.join('\n')); // Write additions
  console.log(`Generated ${generatedScreensCount} screens.`);
  
  if (appRoutesAdditions.length > 0) {
    let appRoutesContent = fs.readFileSync(appRoutesPath, 'utf8');
    appRoutesContent = appRoutesContent.replace(/}\s*$/, `\n${appRoutesAdditions.join('\n')}\n}\n`);
    fs.writeFileSync(appRoutesPath, appRoutesContent);
    console.log("Updated app_routes.dart");
  }

  if (appRouterRoutes.length > 0) {
    let appRouterContent = fs.readFileSync(appRouterPath, 'utf8');
    // Inject imports
    appRouterContent = appRouterContent.replace(/(import '..\/offices\/client\/roles\/client\/client_dashboard.dart' as patient_dash;\s*\n)/, `$1${appRouterImports.join('\n')}\n`);
    
    // Inject routes into the massive ShellRoute
    appRouterContent = appRouterContent.replace(/(        GoRoute\(\s*path: AppRoutes\.pswSettings,[\s\S]*?\),)/, `$1\n${appRouterRoutes.join('\n')}`);
    fs.writeFileSync(appRouterPath, appRouterContent);
    console.log("Updated app_router.dart");
  }
}

main();
