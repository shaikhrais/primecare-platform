const fs = require('fs');
const content = fs.readFileSync('lib/main.dart', 'utf-8');

let newContent = content.replace(
  "import 'features/mt/mt_credentials_screen.dart';", 
  "import 'features/mt/mt_credentials_screen.dart';\nimport 'features/shared/role_mentor_screen.dart';"
);

// Add the Mentor routes sequentially to each section securely natively
newContent = newContent.replace("GoRoute(path: '/psw/daily-timeline'", "GoRoute(path: '/psw/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'psw')),\n          GoRoute(path: '/psw/daily-timeline'");
newContent = newContent.replace("GoRoute(path: '/rn/profile'", "GoRoute(path: '/rn/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'rn')),\n          GoRoute(path: '/rn/profile'");
newContent = newContent.replace("GoRoute(path: '/client/profile'", "GoRoute(path: '/client/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'client')),\n          GoRoute(path: '/client/profile'");
newContent = newContent.replace("GoRoute(path: '/admin/settings'", "GoRoute(path: '/admin/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'admin')),\n          GoRoute(path: '/admin/settings'");
newContent = newContent.replace("GoRoute(path: '/coordinator/fleet-matrix'", "GoRoute(path: '/coordinator/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'coordinator')),\n          GoRoute(path: '/coordinator/fleet-matrix'");
newContent = newContent.replace("GoRoute(path: '/manager/profile'", "GoRoute(path: '/manager/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'manager')),\n          GoRoute(path: '/manager/profile'");

// Inject GM and Scrum Master alongside MT strictly natively tracking correct routing brackets
newContent = newContent.replace("GoRoute(path: '/mt/messages', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.mtMessagesActive)))),", 
"GoRoute(path: '/mt/messages', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.mtMessagesActive)))),\n          GoRoute(path: '/mt/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'mt')),\n          // ======================= GM =======================\n          GoRoute(path: '/gm/dashboard', builder: (context, state) => GmDashboardScreen()),\n          GoRoute(path: '/gm/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'gm')),\n          // ======================= SCRUM MASTER ===========\n          GoRoute(path: '/scrum-master/dashboard', builder: (context, state) => ScrumMasterDashboardScreen()),\n          GoRoute(path: '/scrum-master/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'scrum_master')),");

fs.writeFileSync('lib/main.dart', newContent);
console.log("main.dart patched natively");
