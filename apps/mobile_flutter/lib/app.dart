import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'core/theme_provider.dart';
import 'core/locale_provider.dart';
import 'core/routing/app_router.dart';
import 'core/utils/scaffold_messenger.dart';

class PrimeCareScrollBehavior extends ScrollBehavior {
  const PrimeCareScrollBehavior();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}

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
      scaffoldMessengerKey: globalMessengerKey,
      routerConfig: appRouter,
      locale: locale,
      scrollBehavior: const PrimeCareScrollBehavior(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
