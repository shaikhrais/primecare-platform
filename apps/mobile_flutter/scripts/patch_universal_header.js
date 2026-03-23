const fs = require('fs');

// 1. Patch main.dart
let main = fs.readFileSync('lib/main.dart', 'utf8');
if (!main.includes('theme_provider.dart')) {
    main = main.replace("import 'core/theme.dart';", "import 'core/theme.dart';\nimport 'core/theme_provider.dart';");
}
main = main.replace("themeMode: ThemeMode.system,", "themeMode: ref.watch(themeProvider),");
fs.writeFileSync('lib/main.dart', main);

// 2. Patch global_top_bar.dart
let topBar = fs.readFileSync('lib/core/widgets/global_top_bar.dart', 'utf8');
if (!topBar.includes('flutter_riverpod')) {
    topBar = topBar.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport '../theme_provider.dart';");
}
topBar = topBar.replace('class GlobalTopBar extends StatelessWidget', 'class GlobalTopBar extends ConsumerWidget');
topBar = topBar.replace('Widget build(BuildContext context) {', 'Widget build(BuildContext context, WidgetRef ref) {\n    final isDark = ref.watch(themeProvider) == ThemeMode.dark;');
topBar = topBar.replace('const LanguageToggleButton(),', 
`        const LanguageToggleButton(),
        const SizedBox(width: 8),
        IconButton(
          tooltip: 'Toggle Theme',
          icon: PrimeCareIcon(isDark ? Icons.light_mode : Icons.dark_mode, color: PrimeCareColors.radarDark),
          onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
        ),`);
fs.writeFileSync('lib/core/widgets/global_top_bar.dart', topBar);

// 3. Patch psw_shell_screen.dart
let shell = fs.readFileSync('lib/features/psw/psw_shell_screen.dart', 'utf8');
if (!shell.includes('global_top_bar.dart')) {
    shell = shell.replace("import 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart';\nimport '../../core/widgets/global_top_bar.dart';");
}
// Wrap the existing ResponsiveShell in PrimeCareScaffold natively
if (!shell.includes('appBar: const GlobalTopBar(')) {
    shell = shell.replace('return ResponsiveShell(', `return PrimeCareScaffold(
      appBar: const GlobalTopBar(title: 'PrimeCare Platform'),
      body: ResponsiveShell(`);
    shell = shell.replace(/],?\s*\n\s*\);\s*\n\s*}/m, '],\n      ),\n    );\n  }');
}
fs.writeFileSync('lib/features/psw/psw_shell_screen.dart', shell);

// 4. Strip nested appBars violently from child screens recursively natively
const screens = [
    'lib/features/psw/psw_home_screen.dart',
    'lib/features/psw/psw_dashboard_screen.dart',
    'lib/features/psw/psw_clients_screen.dart',
    'lib/features/psw/psw_timesheet_screen.dart',
    'lib/features/psw/psw_profile_screen.dart'
];

screens.forEach(file => {
    if (fs.existsSync(file)) {
        let code = fs.readFileSync(file, 'utf8');
        // Eradicate duplicated appBar objects mapping
        code = code.replace(/appBar:\s*[a-zA-Z0-9_]+\([\s\S]*?body:/, 'body:');
        fs.writeFileSync(file, code);
    }
});

console.log('Successfully executed architecture overwrite!');
