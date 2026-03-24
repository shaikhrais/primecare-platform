const fs = require('fs');

// 1. Modifying Inbox Screen to securely tap down into the Chat Array natively
let inboxCode = fs.readFileSync('lib/features/shared/universal_inbox_screen.dart', 'utf8');

inboxCode = inboxCode.replace(
    /onTap:\s*\(\)\s*\{\s*ScaffoldMessenger\.of\(context\)\.showSnackBar\(SnackBar\(content:\s*Text\("Initiating secure connection mapping Thread ID:\s*\$\{t\.id\}\.\.\."\)\)\);\s*\}/g,
    "onTap: () { context.push('/${widget.rolePrefix}/inbox/thread/${t.id}'); }"
);

if (!inboxCode.includes("import 'package:go_router/go_router.dart';")) {
    inboxCode = inboxCode.replace(
        "import 'package:primecare_ui/primecare_ui.dart';",
        "import 'package:primecare_ui/primecare_ui.dart';\nimport 'package:go_router/go_router.dart';"
    );
}

fs.writeFileSync('lib/features/shared/universal_inbox_screen.dart', inboxCode);

// 2. Modifying Main.dart structurally defining the sub-routes inherently
let mainCode = fs.readFileSync('lib/main.dart', 'utf8');

if (!mainCode.includes('universal_chat_thread_screen.dart')) {
    mainCode = mainCode.replace(
        "import 'features/shared/universal_inbox_screen.dart';",
        "import 'features/shared/universal_inbox_screen.dart';\nimport 'features/shared/universal_chat_thread_screen.dart';\nimport 'features/shared/universal_call_screen.dart';"
    );
}

if (!mainCode.includes("path: '/:role/inbox/thread/:id'")) {
    const threadRoute = `          GoRoute(path: '/:role/inbox/thread/:id', builder: (context, state) => UniversalChatThreadScreen(rolePrefix: state.pathParameters['role'] ?? 'psw', threadId: state.pathParameters['id']!)),
          GoRoute(path: '/:role/call/:userId', builder: (context, state) => UniversalCallScreen(rolePrefix: state.pathParameters['role'] ?? 'psw', userId: state.pathParameters['userId']!)),`;
          
    mainCode = mainCode.replace(
        "GoRoute(path: '/:role/inbox', builder: (context, state) => UniversalInboxScreen(rolePrefix: state.pathParameters['role'] ?? 'psw')),",
        "GoRoute(path: '/:role/inbox', builder: (context, state) => UniversalInboxScreen(rolePrefix: state.pathParameters['role'] ?? 'psw')),\n" + threadRoute
    );
}
fs.writeFileSync('lib/main.dart', mainCode);

console.log("Routes physically patched into the platform matrix!");
