const fs = require('fs');

let f1 = 'lib/features/dashboard/dashboard_screen.dart';
let c1 = fs.readFileSync(f1, 'utf8');
c1 = c1.replace(/appBar: PrimeCareNavBar\([\s\S]*?,\n\s{8}\],\n\s{6}\),\n/, "appBar: GlobalTopBar(\n        title: 'PrimeCare System Matrix',\n        onLogout: () => _handleLogout(),\n      ),\n");
if (!c1.includes('global_top_bar.dart')) {
    c1 = c1.replace("import 'package:go_router/go_router.dart';", "import 'package:go_router/go_router.dart';\nimport '../../core/widgets/global_top_bar.dart';");
}
fs.writeFileSync(f1, c1);
console.log('Patched dashboard_screen.dart');

let f2 = 'lib/features/psw/psw_home_screen.dart';
let c2 = fs.readFileSync(f2, 'utf8');
c2 = c2.replace(/appBar: PrimeCareNavBar\([\s\S]*?,\n\s{8}\],\n\s{6}\),\n/, "appBar: GlobalTopBar(\n        title: AppLocalizations.of(context)!.appName,\n      ),\n");
if (!c2.includes('global_top_bar.dart')) {
    c2 = c2.replace("import 'package:go_router/go_router.dart';", "import 'package:go_router/go_router.dart';\nimport '../../../core/widgets/global_top_bar.dart';");
}
// Strip the duplicate/unused LanguageToggleButton import we put earlier.
c2 = c2.replace(/import '\.\.\/\.\.\/\.\.\/core\/widgets\/language_toggle_button\.dart';\r?\n/g, '');

fs.writeFileSync(f2, c2);
console.log('Patched psw_home_screen.dart');

// Do client_dashboard_screen.dart too.
let f3 = 'lib/features/client/client_dashboard_screen.dart';
if (fs.existsSync(f3)) {
    let c3 = fs.readFileSync(f3, 'utf8');
    c3 = c3.replace(/appBar: PrimeCareNavBar\([\s\S]*?,\n\s{8}\],\n\s{6}\),\n/, "appBar: GlobalTopBar(\n        title: AppLocalizations.of(context)!.appName,\n      ),\n");
    if (!c3.includes('global_top_bar.dart')) {
        c3 = c3.replace("import 'package:go_router/go_router.dart';", "import 'package:go_router/go_router.dart';\nimport '../../core/widgets/global_top_bar.dart';");
    }
    fs.writeFileSync(f3, c3);
    console.log('Patched client_dashboard_screen.dart');
}

// Do mt_dashboard_screen.dart too.
let f4 = 'lib/features/mt/mt_dashboard_screen.dart';
if (fs.existsSync(f4)) {
    let c4 = fs.readFileSync(f4, 'utf8');
    c4 = c4.replace(/appBar: PrimeCareNavBar\([\s\S]*?,\n\s{8}\],\n\s{6}\),\n/, "appBar: GlobalTopBar(\n        title: AppLocalizations.of(context)!.appName,\n      ),\n");
    if (!c4.includes('global_top_bar.dart')) {
        c4 = c4.replace("import 'package:go_router/go_router.dart';", "import 'package:go_router/go_router.dart';\nimport '../../core/widgets/global_top_bar.dart';");
    }
    fs.writeFileSync(f4, c4);
    console.log('Patched mt_dashboard_screen.dart');
}
