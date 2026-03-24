const fs = require('fs');
let mainCode = fs.readFileSync('lib/main.dart', 'utf8');

mainCode = mainCode.replace(/import 'features\/gm\/gm_dashboard_screen\.dart';\r?\n?/g, "");
mainCode = mainCode.replace(/import 'features\/mt\/mt_dashboard_screen\.dart';\r?\n?/g, "");
mainCode = mainCode.replace(/import 'features\/coordinator\/coordinator_dashboard_screen\.dart';\r?\n?/g, "");
mainCode = mainCode.replace(/import 'features\/scrum_master\/scrum_master_dashboard_screen\.dart';\r?\n?/g, "");
mainCode = mainCode.replace(/import 'features\/scrum-master\/scrum_master_dashboard_screen\.dart';\r?\n?/g, "");

fs.writeFileSync('lib/main.dart', mainCode);
console.log("Dead imports purged completely!");
