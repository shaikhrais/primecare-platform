const fs = require('fs');

// Fix global_top_bar.dart
let f0 = 'lib/core/widgets/global_top_bar.dart';
let c0 = fs.readFileSync(f0, 'utf8');
c0 = c0.replace(/PrimeCareColors\.blue/g, 'PrimeCareColors.ocean');
fs.writeFileSync(f0, c0);

// Fix dashboard_screen.dart
let f1 = 'lib/features/dashboard/dashboard_screen.dart';
let c1 = fs.readFileSync(f1, 'utf8');
let idx1 = c1.indexOf('appBar: PrimeCareNavBar(');
if (idx1 !== -1) {
    let endIdx1 = c1.indexOf('),', c1.indexOf('actions: [', idx1)) + 2;
    if (endIdx1 > 2) {
        c1 = c1.substring(0, idx1) + "appBar: GlobalTopBar(\n        title: 'PrimeCare Matrix Dasboard',\n        onLogout: () => _handleLogout(),\n      )," + c1.substring(endIdx1);
        fs.writeFileSync(f1, c1);
    }
}

// Fix psw_home_screen.dart
let f2 = 'lib/features/psw/psw_home_screen.dart';
let c2 = fs.readFileSync(f2, 'utf8');
let idx2 = c2.indexOf('appBar: PrimeCareNavBar(');
if (idx2 !== -1) {
    let endIdx2 = c2.indexOf('],', idx2);
    let finalEnd2 = c2.indexOf('),', endIdx2) + 2;
    if (finalEnd2 > 2) {
        c2 = c2.substring(0, idx2) + "appBar: GlobalTopBar(\n        title: AppLocalizations.of(context)!.appName,\n      )," + c2.substring(finalEnd2);
        fs.writeFileSync(f2, c2);
    }
}

// Fix psw_growth_dashboard_screen.dart
let f3 = 'lib/features/psw/psw_growth_dashboard_screen.dart';
if (fs.existsSync(f3)) {
    let c3 = fs.readFileSync(f3, 'utf8');
    c3 = c3.replace(/[ \t]*iconTheme:.*?\n/g, '');
    c3 = c3.replace(/[ \t]*foregroundColor:.*?\n/g, '');
    fs.writeFileSync(f3, c3);
}

// Ensure global_top_bar is imported
if (!c1.includes('global_top_bar.dart')) c1 = c1.replace("import 'package:go_router/go_router.dart';", "import 'package:go_router/go_router.dart';\nimport '../../core/widgets/global_top_bar.dart';");
if (!c2.includes('global_top_bar.dart')) c2 = c2.replace("import 'package:go_router/go_router.dart';", "import 'package:go_router/go_router.dart';\nimport '../../../core/widgets/global_top_bar.dart';");

fs.writeFileSync(f1, c1);
fs.writeFileSync(f2, c2);

console.log('Fixed syntax constraints globally');
