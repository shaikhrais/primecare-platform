const fs = require('fs');
const filePath = 'lib/main.dart';
let code = fs.readFileSync(filePath, 'utf8');

// Scrub isolated root-level generic routes
code = code.replace(/GoRoute\(path:\s*'\/:role\/dashboard'[^\)]+\)\),/g, "");
code = code.replace(/GoRoute\(path:\s*'\/:role\/inbox'[^\)]+\)\),/g, "");

// Inject into the correct ShellRoute internal block
const pswComment = '// ======================= PSW =======================';
if (code.includes(pswComment) && !code.includes("GoRoute(path: '/:role/dashboard'")) {
    const newRoutes = `          // ======================= GLOBAL DYNAMIC ROUTING =======================\n          GoRoute(path: '/:role/dashboard', builder: (context, state) => UniversalDashboardScreen(rolePrefix: state.pathParameters['role'] ?? 'psw')),\n          GoRoute(path: '/:role/inbox', builder: (context, state) => UniversalInboxScreen(rolePrefix: state.pathParameters['role'] ?? 'psw')),\n\n          `;
    code = code.replace(pswComment, newRoutes + pswComment);
}

fs.writeFileSync(filePath, code);
console.log('Fixed ShellRoute wrapper location successfully!');
