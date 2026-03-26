const fs = require('fs');

const filesToFix = [
  'lib/features/master/shared/role_sow_screen.dart',
  'lib/features/roles/coordinator/coordinator_callin_screen.dart',
  'lib/features/roles/coordinator/coordinator_visit_adjustment_screen.dart',
  'lib/features/roles/coordinator/screens/coordinator_callin_screen.dart',
  'lib/features/roles/manager/screens/manager_incidents_screen.dart',
  'lib/features/roles/rn/rn_med_recon_screen.dart',
  'lib/features/roles/scrum_master/tracking_matrix_screen.dart',
  'lib/features/roles/superuser/superuser_territory_map_screen.dart'
];

filesToFix.forEach(f => {
  if (fs.existsSync(f)) {
    let content = fs.readFileSync(f, 'utf8');
    content = content.replace(/['"]\.\.\/\.\.\/core\/(.*?)['"]/g, "'package:primecare_mobile/core/$1'");
    content = content.replace(/['"]\.\.\/\.\.\/\.\.\/\.\.\/core\/(.*?)['"]/g, "'package:primecare_mobile/core/$1'");
    content = content.replace(/['"]\.\.\/\.\.\/\.\.\/\.\.\/config\/(.*?)['"]/g, "'package:primecare_mobile/config/$1'");
    fs.writeFileSync(f, content, 'utf8');
  }
});

// Fix Test Files
const testFiles = ['test/core/universal_smoke_test.dart', 'test/widget_test.dart'];
function fixTest(f) {
  if (fs.existsSync(f)) {
    let content = fs.readFileSync(f, 'utf8');
    const roleFolders = ['admin', 'client', 'coordinator', 'gm', 'manager', 'mt', 'psw', 'rn', 'scrum_master', 'superuser'];
    const masterFolders = ['auth', 'home', 'messaging', 'payment', 'shared', 'telemetry'];
    
    roleFolders.forEach(folder => {
      content = content.split(`package:primecare_mobile/features/${folder}`).join(`package:primecare_mobile/features/roles/${folder}`);
    });
    masterFolders.forEach(folder => {
      content = content.split(`package:primecare_mobile/features/${folder}`).join(`package:primecare_mobile/features/master/${folder}`);
    });
    fs.writeFileSync(f, content, 'utf8');
  }
}

testFiles.forEach(fixTest);

console.log('Fixed relative paths structurally cleanly neatly seamlessly.');
