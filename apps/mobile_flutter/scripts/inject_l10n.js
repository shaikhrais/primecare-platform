const fs = require('fs');
const path = require('path');

const srcRoot = path.join(__dirname, '..', 'lib');

function replaceStrings(filePath) {
    if (!fs.existsSync(filePath)) return;
    let content = fs.readFileSync(filePath, 'utf8');
    let original = content;

    // Replace explicit string constants with contextual native Localizations
    content = content.replace(/AppStrings\.([a-zA-Z0-9_]+)/g, 'AppLocalizations.of(context)!.$1');

    if (content !== original) {
        // Inject physical dependency natively
        if (!content.includes('package:flutter_gen/gen_l10n/app_localizations.dart')) {
            content = "import 'package:flutter_gen/gen_l10n/app_localizations.dart';\n" + content;
        }
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`[Replaced localizations] ${path.basename(filePath)}`);
    }
}

// 1. Process specifically identified local targets
const targetFiles = [
    path.join(srcRoot, 'features', 'shared', 'screens', 'theme_control_screen.dart'),
    path.join(srcRoot, 'features', 'psw', 'psw_home_screen.dart'),
    path.join(srcRoot, 'features', 'psw', 'psw_dashboard_screen.dart')
];
targetFiles.forEach(replaceStrings);

// 2. Inject Locale logic inside Theme Control Center to allow execution mutation
const themeControlPath = path.join(srcRoot, 'features', 'shared', 'screens', 'theme_control_screen.dart');
if (fs.existsSync(themeControlPath)) {
    let t = fs.readFileSync(themeControlPath, 'utf8');
    if (!t.includes('localeProvider')) {
        t = "import 'package:primecare_mobile/core/locale_provider.dart';\n" + t;
        
        // Append Locale Toggle directly into the UI mapping list manually
        if (t.includes('children: [')) {
             t = t.replace('children: [', `children: [
          PrimeCareCard(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimeCareText('Language / Langue', style: Theme.of(context).textTheme.titleMedium, color: Theme.of(context).colorScheme.primary),
                  const PrimeCareSizedBox(height: 16),
                  RadioListTile<Locale>(
                    title: const PrimeCareText('English (en)'),
                    value: const Locale('en'),
                    groupValue: ref.watch(localeProvider),
                    onChanged: (val) {
                      if (val != null) ref.read(localeProvider.notifier).state = val;
                    },
                  ),
                  RadioListTile<Locale>(
                    title: const PrimeCareText('Français (fr)'),
                    value: const Locale('fr'),
                    groupValue: ref.watch(localeProvider),
                    onChanged: (val) {
                      if (val != null) ref.read(localeProvider.notifier).state = val;
                    },
                  ),
                ],
              ),
            ),
          ),
          const PrimeCareSizedBox(height: 24),`);
        }
        fs.writeFileSync(themeControlPath, t, 'utf8');
        console.log('[Injected Locale Toggle] theme_control_screen.dart');
    }
}

// 3. Inject global bounds into main.dart
const mainPath = path.join(srcRoot, 'main.dart');
if (fs.existsSync(mainPath)) {
    let m = fs.readFileSync(mainPath, 'utf8');
    if (!m.includes('localeProvider')) {
        m = "import 'package:flutter_gen/gen_l10n/app_localizations.dart';\nimport 'package:primecare_mobile/core/locale_provider.dart';\n" + m;
        // Inject into MaterialApp.router securely avoiding collision
        m = m.replace(/routerConfig: _router,/g, `routerConfig: _router,
      locale: ref.watch(localeProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,`);
        fs.writeFileSync(mainPath, m, 'utf8');
        console.log('[Wired Master Logic] main.dart');
    }
}
