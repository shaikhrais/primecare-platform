const fs = require('fs');
const path = require('path');

const roles = [
  { group: 'corporate', name: 'Founder / CEO', id: 'founder_ceo' },
  { group: 'corporate', name: 'COO (Operations Head)', id: 'coo' },
  { group: 'corporate', name: 'CFO (Finance Head)', id: 'cfo' },
  { group: 'corporate', name: 'CTO (Tech Head)', id: 'cto' },
  { group: 'corporate', name: 'Compliance Manager', id: 'compliance' },
  { group: 'corporate', name: 'Head of Business Development', id: 'head_bd' },
  { group: 'corporate', name: 'Head of Marketing', id: 'head_marketing' },
  { group: 'corporate', name: 'Training Director', id: 'training_director' },
  { group: 'business_development', name: 'Business Development Team', id: 'bd_team' },
  { group: 'business_development', name: 'Regional Business Development Manager (Ontario)', id: 'regional_bd_on' },
  { group: 'business_development', name: 'Regional Business Development Manager (USA)', id: 'regional_bd_usa' },
  { group: 'business_development', name: 'Franchise Sales Manager', id: 'franchise_sales' },
  { group: 'business_development', name: 'Partnership Manager', id: 'partnership_mgr' },
  { group: 'business_development', name: 'Territory Expansion Manager', id: 'territory_expansion' },
  { group: 'franchise_management', name: 'Franchise Level', id: 'franchise_level' },
  { group: 'franchise_management', name: 'Franchise Owner', id: 'franchise_owner' },
  { group: 'franchise_management', name: 'Operations Manager', id: 'operations_mgr' },
  { group: 'franchise_management', name: 'Scheduler / Coordinator', id: 'scheduler' },
  { group: 'franchise_management', name: 'Billing / Admin', id: 'billing' },
  { group: 'franchise_management', name: 'HR / Hiring', id: 'hr' },
  { group: 'clinical', name: 'Clinical Team', id: 'clinical_team' },
  { group: 'clinical', name: 'RN (Registered Nurse)', id: 'rn_granular' },
  { group: 'clinical', name: 'RPN', id: 'rpn' },
  { group: 'clinical', name: 'RMT', id: 'rmt' },
  { group: 'clinical', name: 'PSW', id: 'psw_granular' },
  { group: 'support', name: 'Support Team', id: 'support_team' },
  { group: 'support', name: 'Customer Support', id: 'customer_support' },
  { group: 'support', name: 'Intake Coordinator', id: 'intake_coordinator' },
  { group: 'support', name: 'Quality Assurance', id: 'quality_assurance' },
  { group: 'support', name: 'Training Coordinator', id: 'training_coordinator' },
  { group: 'marketing', name: 'Marketing and Local Growth', id: 'marketing_growth' },
  { group: 'marketing', name: 'Local Marketing Manager', id: 'local_marketing' },
  { group: 'marketing', name: 'Community Outreach', id: 'community_outreach' },
  { group: 'marketing', name: 'Territory Sales Manager', id: 'territory_sales' },
  { group: 'client', name: 'Client Side', id: 'client_side' },
  { group: 'client', name: 'Client', id: 'client_granular' },
  { group: 'client', name: 'Family Member', id: 'family_member' }
];

function pascalCase(str) {
  return str.split('_').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join('');
}

function camelCase(str) {
  let p = pascalCase(str);
  return p.charAt(0).toLowerCase() + p.slice(1);
}

let appRoutes = '';
let screenImports = '';
let screenRegistry = '';
let dynamicRoutes = '';

const featuresDir = path.join(__dirname, '../lib/features/roles');

roles.forEach(role => {
  const dirPath = path.join(featuresDir, role.group, 'screens');
  if (!fs.existsSync(dirPath)) {
    fs.mkdirSync(dirPath, { recursive: true });
  }

  const className = `${pascalCase(role.id)}DashboardScreen`;
  const fileName = `${role.id}_dashboard_screen.dart`;
  const filePath = path.join(dirPath, fileName);
  
  const content = `import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ${className} extends StatelessWidget {
  const ${className}({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimeCareAppBar(title: '${role.name.replace(/'/g, "\\'")} Dashboard'),
      body: Center(
        child: Text('${role.name.replace(/'/g, "\\'")} view coming soon...'),
      ),
    );
  }
}
`;
  fs.writeFileSync(filePath, content);
  
  const rolenameCamel = camelCase(role.id) + 'Dashboard';
  appRoutes += `  static const String ${rolenameCamel} = '/${role.group.replace(/_/g, '-')}/${role.id.replace(/_/g, '-')}';\n`;
  screenImports += `import 'package:primecare_mobile/features/roles/${role.group}/screens/${fileName}';\n`;
  screenRegistry += `      case '${role.id}_dashboard': return const ${className}();\n`;
  dynamicRoutes += `      GoRoute(path: AppRoutes.${rolenameCamel}, builder: (context, state) => ScreenRegistry.resolveScreen('${role.id}_dashboard', {})),\n`;
});

// Patching app_routes.dart
const appRoutesPath = path.join(__dirname, '../lib/core/routing/app_routes.dart');
let appRoutesContent = fs.readFileSync(appRoutesPath, 'utf8');
if (!appRoutesContent.includes('// Granular Dashboard Routes')) {
  appRoutesContent = appRoutesContent.replace(/}\s*$/, `\n  // Granular Dashboard Routes\n${appRoutes}}\n`);
  fs.writeFileSync(appRoutesPath, appRoutesContent);
}

// Patching screen_registry.dart
const screenRegistryPath = path.join(__dirname, '../lib/core/routing/screen_registry.dart');
let screenRegContent = fs.readFileSync(screenRegistryPath, 'utf8');
if (!screenRegContent.includes('Granular Screen Imports')) {
  screenRegContent = screenRegContent.replace(`import 'package:flutter/material.dart';`, `import 'package:flutter/material.dart';\n\n// Granular Screen Imports\n${screenImports}`);
  screenRegContent = screenRegContent.replace('default:', `// Granular Registry Mappings\n${screenRegistry}      default:`);
  fs.writeFileSync(screenRegistryPath, screenRegContent);
}

// Patching dynamic_route_engine.dart
const dynamicRouteEnginePath = path.join(__dirname, '../lib/core/routing/dynamic_route_engine.dart');
let dynContent = fs.readFileSync(dynamicRouteEnginePath, 'utf8');
if (!dynContent.includes('Granular Routes Engine Definitions')) {
  dynContent = dynContent.replace(/\];\s*}\s*}\s*$/, `// Granular Routes Engine Definitions\n${dynamicRoutes}    ];\n  }\n}\n`);
  fs.writeFileSync(dynamicRouteEnginePath, dynContent);
}

console.log("36 Directory Dashboards successfully generated and injected into the Router Matrix!");
