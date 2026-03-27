import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'core/theme_provider.dart';
import 'core/locale_provider.dart';
import 'core/routing/app_router.dart';

class PrimeCareApp extends ConsumerWidget {
  const PrimeCareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.primecareMobile,
      theme: AppTheme.lightTheme,
      themeMode: ref.watch(themeProvider),
      routerConfig: appRouter,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
