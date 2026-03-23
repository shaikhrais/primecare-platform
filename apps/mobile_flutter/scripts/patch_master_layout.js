const fs = require('fs');
const path = require('path');

const mainDartPath = path.join(__dirname, '../lib/main.dart');
let content = fs.readFileSync(mainDartPath, 'utf8');

// The structural injection relies on isolating the GoRouter array exactly at `routes: [`
const routesStartIndex = content.indexOf('routes: [');
if (routesStartIndex === -1) {
    console.error("CRITICAL: Failed to locate GoRouter array index.");
    process.exit(1);
}

// Locate the block containing just unauthenticated paths: Login & Forgot Password
const unauthRoutesBlockRegex = /GoRoute\([\s\S]*?path:\s*'\/login'[\s\S]*?,\s*GoRoute\([\s\S]*?path:\s*'\/forgot-password'[\s\S]*?,\s*/;
const match = content.match(unauthRoutesBlockRegex);

if (!match) {
    console.error("CRITICAL: Failed to isolate explicitly defined unauthenticated schemas natively.");
    process.exit(1);
}

const unauthString = match[0];
// Ensure standard imports are added once
if (!content.includes("import '../../core/api_client.dart';")) {
  content = content.replace("import 'core/network/offline_sync_manager.dart';", "import 'core/network/offline_sync_manager.dart';\nimport 'core/api_client.dart';\nimport 'core/widgets/global_top_bar.dart';\nimport 'package:primecare_ui/primecare_ui.dart';");
}

let patchedContent = content.replace(unauthString, ""); 

// Now, the routes array is clean of unauthenticated. We want to wrap ALL REMAINING items in a ShellRoute.
const injectionPointRegex = /routes:\s*\[/;
patchedContent = patchedContent.replace(injectionPointRegex, `routes: [
      ${unauthString}
      // UNIVERSAL MASTER SHELL ROUTE
      ShellRoute(
        builder: (context, state, child) {
          return PrimeCareScaffold(
            appBar: GlobalTopBar(
              title: 'PrimeCare Platform',
              onLogout: () async {
                await apiClient.logout();
                context.go('/login');
              },
            ),
            body: child,
          );
        },
        routes: [`);

// To close the ShellRoute at the bottom of the GoRouter array correctly, we substitute the final `] // end routes` with `],), // end routes`
// Assuming GoRouter ends near the end
const routerEndRegex = /\]\s*,\s*\)\s*;\s*\}\)\s*;/;
patchedContent = patchedContent.replace(routerEndRegex, '    ],\n      ),\n    ],\n  );\n});');

fs.writeFileSync(mainDartPath, patchedContent, 'utf8');
console.log("Successfully rebuilt core architecture wrapping all domain clusters under the PrimeCare Universal TopBar.");
