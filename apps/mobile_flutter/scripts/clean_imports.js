const fs = require('fs');
const path = require('path');

const mainDartPath = path.join(__dirname, '../lib/main.dart');
const content = fs.readFileSync(mainDartPath, 'utf8');

// Filter out all lines that import a shell_screen
const lines = content.split('\n');
const cleanedLines = lines.filter(line => !line.includes('shell_screen.dart'));
fs.writeFileSync(mainDartPath, cleanedLines.join('\n'), 'utf8');
console.log('Removed obsolete ShellScreen imports from main.dart');

// Delete the actual files
const shellsToDelete = [
  'features/psw/psw_shell_screen.dart',
  'features/rn/rn_shell_screen.dart',
  'features/client/client_shell_screen.dart',
  'features/coordinator/coordinator_shell_screen.dart',
  'features/manager/manager_shell_screen.dart',
  'features/scrum_master/scrum_master_shell_screen.dart',
  'features/gm/gm_shell_screen.dart',
  'features/mt/mt_shell_screen.dart',
  'features/admin/admin_shell_screen.dart'
];

shellsToDelete.forEach(file => {
  const fullPath = path.join(__dirname, '../lib', file);
  if (fs.existsSync(fullPath)) {
    fs.unlinkSync(fullPath);
    console.log('Deleted obsolete shell: ' + file);
  }
});
