const fs = require('fs');
const filepath = 'c:/Users/Admin2/Documents/GitHub/primecare-platform/packages/flutter_core/lib/flutter_core.dart';
let content = fs.readFileSync(filepath, 'utf8');
content += "\nexport 'registry/widgets/responsive_grid.dart';\n";
fs.writeFileSync(filepath, content);
console.log('Export added to flutter_core.dart');
