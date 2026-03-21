const fs = require('fs');

let content = fs.readFileSync('lib/main.dart', 'utf8');

if (!content.includes("import 'core/locale_provider.dart';")) {
  content = content.replace(
    "import 'package:flutter_riverpod/flutter_riverpod.dart';",
    "import 'package:flutter_riverpod/flutter_riverpod.dart';\nimport 'core/locale_provider.dart';"
  );
}

content = content.replace(
  "final appRouter = ref.watch(routerProvider);",
  "final appRouter = ref.watch(routerProvider);\n    final locale = ref.watch(localeProvider);"
);

content = content.replace(
  "title: AppLocalizations.of(context)!.primecareMobile,",
  "onGenerateTitle: (context) => AppLocalizations.of(context)!.primecareMobile,"
);

content = content.replace(
  "routerConfig: appRouter,",
  "routerConfig: appRouter,\n      locale: locale,\n      localizationsDelegates: AppLocalizations.localizationsDelegates,\n      supportedLocales: AppLocalizations.supportedLocales,"
);

fs.writeFileSync('lib/main.dart', content);
console.log('Successfully patched lib/main.dart with routing delegates.');
