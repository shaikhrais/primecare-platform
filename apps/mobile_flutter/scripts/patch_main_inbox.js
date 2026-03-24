const fs = require('fs');
const path = require('path');

const mainPath = path.join(__dirname, '..', 'lib', 'main.dart');
let mainCode = fs.readFileSync(mainPath, 'utf8');

if (!mainCode.includes("import 'features/shared/universal_inbox_screen.dart';")) {
  mainCode = "import 'features/shared/universal_inbox_screen.dart';\n" + mainCode;
}

// Ensure the dynamic GoRouter path logic traps the inbox parameter cleanly before generic overrides
const inboxRoute = `GoRoute(path: '/:role/inbox', builder: (context, state) => UniversalInboxScreen(rolePrefix: state.pathParameters['role'] ?? 'psw')),`;

if (!mainCode.includes(inboxRoute)) {
  mainCode = mainCode.replace("routes: [", "routes: [\n        " + inboxRoute + "\n");
}

fs.writeFileSync(mainPath, mainCode);
console.log('Main.dart globally patched mapping the Universal Inbox to all roles properly!');
