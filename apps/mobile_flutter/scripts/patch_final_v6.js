const fs = require('fs');

let log = fs.readFileSync('lib/features/auth/login_screen.dart', 'utf8');
log = log.replace(/constraints:\s*BoxConstraints\(maxWidth:\s*400\),/g, '');
fs.writeFileSync('lib/features/auth/login_screen.dart', log);

let fp = fs.readFileSync('lib/features/auth/forgot_password_screen.dart', 'utf8');
fp = fp.replace(/constraints:\s*BoxConstraints\(maxWidth:\s*400\),/g, '');
fp = fp.replace(/iconTheme:\s*IconThemeData\(color:\s*Colors\.white\),/g, '');
fs.writeFileSync('lib/features/auth/forgot_password_screen.dart', fp);

let psh = fs.readFileSync('lib/features/psw/psw_home_screen.dart', 'utf8');
psh = psh.replace(/AppLocalizations\.of\(context\)!\.welcomeBack/g, "'Welcome Back'");
psh = psh.replace(/AppLocalizations\.of\(context\)!\.nextShiftAnnouncement/g, "'Your next shift starts in...'");
psh = psh.replace(/AppLocalizations\.of\(context\)!\.performanceMetrics/g, "'Performance Metrics'");
psh = psh.replace(/AppLocalizations\.of\(context\)!\.weeklyHoursLabel/g, "'Weekly Hours'");
psh = psh.replace(/AppLocalizations\.of\(context\)!\.complianceLabel/g, "'Compliance'");
fs.writeFileSync('lib/features/psw/psw_home_screen.dart', psh);

let puiPath = '../../packages/primecare_ui/lib/primecare_ui.dart';
if (fs.existsSync(puiPath)) {
  let pui = fs.readFileSync(puiPath, 'utf8');
  pui = pui.replace(/export 'src\/components\/primecare_primitives\.dart';/g, '');
  fs.writeFileSync(puiPath, pui);
  console.log('Repaired relative package architecture export');
} else {
  console.log('Could not find ' + puiPath);
}
