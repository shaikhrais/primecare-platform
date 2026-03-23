const fs = require('fs');

// 1. Clean dashboard_screen.dart orphaned brackets
let f1 = 'lib/features/dashboard/dashboard_screen.dart';
let c1 = fs.readFileSync(f1, 'utf8');
c1 = c1.replace(/appBar: GlobalTopBar\([\s\S]*?,\n\s{6}\),\n\s{12}onPressed: _handleLogout,\n\s{12}tooltip: AppLocalizations\.of\(context\)!\.terminateSession,\n\s{10}\),\n\s{8}\],\n\s{6}\),/m, `appBar: GlobalTopBar(
        title: 'PrimeCare Matrix Dashboard',
        onLogout: () => _handleLogout(),
      ),`);
fs.writeFileSync(f1, c1);
console.log('Fixed dashboard_screen.dart');

// 2. Add to client_dashboard_screen.dart
let f2 = 'lib/features/client/client_dashboard_screen.dart';
let c2 = fs.readFileSync(f2, 'utf8');
if (!c2.includes('GlobalTopBar')) {
    c2 = c2.replace(/return PrimeCareScaffold\(\s*body: PrimeCareCenter\(/, `return const PrimeCareScaffold(
      appBar: GlobalTopBar(title: 'Care Transparency Feed'),
      body: PrimeCareCenter(`);
    c2 = c2.replace("import 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart';\nimport '../../core/widgets/global_top_bar.dart';\nimport 'package:primecare_mobile/l10n/app_localizations.dart';");
    fs.writeFileSync(f2, c2);
    console.log('Fixed client_dashboard_screen.dart');
}

// 3. Fix mt_dashboard_screen.dart
let f3 = 'lib/features/mt/mt_dashboard_screen.dart';
let c3 = fs.readFileSync(f3, 'utf8');
if (c3.includes('PrimeCareNavBar')) {
    c3 = c3.replace(/appBar: PrimeCareNavBar\([\s\S]*?elevation: 0,\n\s{6}\),/m, "appBar: const GlobalTopBar(title: 'My Jane Schedule (MT)'),");
    if(!c3.includes('global_top_bar.dart')) {
        c3 = c3.replace("import 'package:go_router/go_router.dart';", "import 'package:go_router/go_router.dart';\nimport '../../core/widgets/global_top_bar.dart';");
    }
    fs.writeFileSync(f3, c3);
    console.log('Fixed mt_dashboard_screen.dart');
}
