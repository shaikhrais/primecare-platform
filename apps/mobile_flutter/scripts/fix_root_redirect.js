const fs = require('fs');

let mainCode = fs.readFileSync('lib/main.dart', 'utf8');

// The original redirect logic checks: `if (hasToken && (isLoggingIn || isGenericDashboard))`
// We need it to intercept the `/` route as well if they are logged in or attempting to log in so it redirects to their role home!

mainCode = mainCode.replace(
    "final isGenericDashboard = state.uri.toString() == '/dashboard';",
    "final isGenericDashboard = state.uri.toString() == '/dashboard';\n      final isRoot = state.uri.toString() == '/';"
);

mainCode = mainCode.replace(
    "if (hasToken && (isLoggingIn || isGenericDashboard)) {",
    "if (hasToken && (isLoggingIn || isGenericDashboard || isRoot)) {"
);

fs.writeFileSync('lib/main.dart', mainCode);
console.log("Root intercept restored successfully!");
