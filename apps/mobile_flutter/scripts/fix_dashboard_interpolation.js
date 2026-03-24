const fs = require('fs');
const filePath = 'lib/features/shared/universal_dashboard_screen.dart';
let code = fs.readFileSync(filePath, 'utf8');
code = code.replace(/\\\$/g, '$');
fs.writeFileSync(filePath, code);
console.log('Fixed dashboard string interpolations natively!');
