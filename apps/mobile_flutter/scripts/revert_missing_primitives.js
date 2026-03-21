const fs = require('fs');

function revert(path) {
  if (fs.existsSync(path)) {
    let content = fs.readFileSync(path, 'utf8');
    content = content.replace(/PrimeCareScrollWrapper/g, 'SingleChildScrollView');
    content = content.replace(/PrimeCareSizedBox/g, 'SizedBox');
    fs.writeFileSync(path, content);
  }
}

revert('lib/features/psw/psw_incident_wizard_screen.dart');
console.log('Reverted missing primitives on incident screen');
