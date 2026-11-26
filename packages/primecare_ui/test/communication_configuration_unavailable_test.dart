import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/registry/intents/app_screen_intent.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/communications/unavailable_configuration_screen.dart';
import 'package:primecare_ui/src/features/generated_screens/cto_integrations.dart';
import 'package:primecare_ui/src/features/generated_screens/integration_health_monitor.dart';

void main() {
  test('compatibility providers fail explicitly rather than returning fake success', () async {
    expect(UnavailableConfigurationScreen.implementationTags['productionReady'], false);
    final container = ProviderContainer();
    addTearDown(container.dispose);
    for (final provider in [cto_integrationsDataProvider, integration_health_monitorDataProvider]) {
      final subscription = container.listen(provider, (_, __) {});
      try {
        await expectLater(container.read(provider.future), throwsA(isA<UnimplementedGovernanceException>()));
      } finally {
        subscription.close();
      }
    }
  });

  for (final language in ['en', 'fr', 'es']) {
    testWidgets('existing provider screens inherit unavailable presentation in $language', (tester) async {
      tester.view.physicalSize = const Size(320, 700);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final semantics = tester.ensureSemantics();
      try {
      for (final screen in [const CtoIntegrationsScreen(), const IntegrationHealthMonitorScreen()]) {
        expect(screen, isA<UnavailableConfigurationScreen>());
        await tester.pumpWidget(ProviderScope(child: PrimeTheme(data: const PrimeThemeData(),
          child: MaterialApp(locale: Locale(language), supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.5)), child: child!),
            home: AppShellBoundary(child: Scaffold(body: screen))))));
        await tester.pumpAndSettle();
        expect(find.text(CommunicationWorkspaceCatalog.text(language, 'unavailable')), findsOneWidget);
        expect(find.byKey(Key('screen-${screen.screenCode.replaceAll('_', '-')}')), findsOneWidget);
        expect(find.text('100% READY'), findsNothing);
        expect(find.byType(ElevatedButton), findsNothing);
        expect(find.byType(TextField), findsNothing);
        expect(tester.takeException(), isNull);
      }
      } finally {
        semantics.dispose();
      }
    });
  }
}
