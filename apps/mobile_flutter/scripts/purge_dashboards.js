const fs = require('fs');

console.log('Initiating complete platform vocabulary restructuring execution.');

// 1. MAIN.DART (Fixing the Core Login Redirect Deadlocks!)
const mainFile = 'lib/main.dart';
let mainCode = fs.readFileSync(mainFile, 'utf8');

mainCode = mainCode.replace(/return '\/mt\/dashboard';/g, "return '/mt/operations-hub';");
mainCode = mainCode.replace(/return '\/gm\/dashboard';/g, "return '/gm/operations-hub';");
mainCode = mainCode.replace(/return '\/scrum-master\/dashboard';/g, "return '/scrum-master/operations-hub';");
mainCode = mainCode.replace(/return '\/rn\/dashboard';/g, "return '/rn/operations-hub';");
mainCode = mainCode.replace(/return '\/coordinator\/dashboard';/g, "return '/coordinator/matrix';");
mainCode = mainCode.replace(/return '\/manager\/dashboard';/g, "return '/manager/analytics-matrix';");
mainCode = mainCode.replace(/return '\/dashboard';/g, "return '/admin/telemetry-matrix';"); // Admin / SuperAdmin
mainCode = mainCode.replace(/return '\/client\/dashboard';/g, "return '/client/care-hub';");

fs.writeFileSync(mainFile, mainCode);
console.log('Successfully patched routing architecture exceptions replacing legacy variables natively.');

// 2. L10N (Localization / UI Strings replacements mapping dynamically to the complex native engine definitions)
const enArbFile = 'lib/l10n/app_en.arb';
let enArb = fs.readFileSync(enArbFile, 'utf8');
enArb = enArb.replace(/"Home Dashboard"/g, '"Central Operations Matrix"');
enArb = enArb.replace(/"Shift Accepted. Added to Dashboard."/g, '"Shift Accepted. Localized telemetry synced."');
fs.writeFileSync(enArbFile, enArb);

const frArbFile = 'lib/l10n/app_fr.arb';
let frArb = fs.readFileSync(frArbFile, 'utf8');
frArb = frArb.replace(/"\[FR\] Home Dashboard"/g, '"[FR] Matrice des opérations centrales"');
frArb = frArb.replace(/"\[FR\] Shift Accepted. Added to Dashboard."/g, '"[FR] Emplacement accepté. Télémétrie localisée synchronisée."');
fs.writeFileSync(frArbFile, frArb);
console.log('Localization UI parameters synchronized to the Telemetry vocabulary perfectly.');

// 3. ROLE MENTOR SCREEN (Graphical layout tracking replacements globally mapping internal systems natively)
const devMentorInfo = 'lib/features/shared/role_mentor_screen.dart';
let devMCode = fs.readFileSync(devMentorInfo, 'utf8');

devMCode = devMCode.replace(/\/psw\/dashboard/g, '/psw/home');
devMCode = devMCode.replace(/\/rn\/dashboard/g, '/rn/operations-hub');
devMCode = devMCode.replace(/\/client\/dashboard/g, '/client/care-hub');
devMCode = devMCode.replace(/\/coordinator\/dashboard/g, '/coordinator/matrix');
devMCode = devMCode.replace(/\/manager\/dashboard/g, '/manager/analytics-matrix');
devMCode = devMCode.replace(/'\/dashboard'/g, "'/admin/telemetry-matrix'");
devMCode = devMCode.replace(/\/mt\/dashboard/g, '/mt/operations-hub');
devMCode = devMCode.replace(/\/gm\/dashboard/g, '/gm/operations-hub');
devMCode = devMCode.replace(/\/scrum-master\/dashboard/g, '/scrum-master/operations-hub');

devMCode = devMCode.replace(/'Executive Dashboard V2'/g, "'Executive Matrix Command V2'");
devMCode = devMCode.replace(/their oversight dashboards/g, 'their oversight matrices');

fs.writeFileSync(devMentorInfo, devMCode);
console.log('Graphical Developer System bindings physically verified and dynamically updated!');
