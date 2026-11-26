import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_client/features/patient/screens/patient_dashboard_screen.dart';
import 'package:primecare_client/features/patient/screens/patient_profile_screen.dart';

void main() {
  for (final example in <(Widget, String)>[
    (const PatientDashboardScreen(), 'The patient dashboard is not available yet.'),
    (const PatientProfileScreen(), 'The patient profile is not available yet.'),
  ]) {
    testWidgets('scaffold presents an honest unavailable state: ${example.$2}', (tester) async {
      await tester.pumpWidget(ProviderScope(child: MaterialApp(
        home: AppShellBoundary(child: example.$1),
      )));
      await tester.pumpAndSettle();
      expect(find.text(example.$2), findsOneWidget);
      expect(find.textContaining('fully implemented'), findsNothing);
      expect(find.byIcon(Icons.check_circle_outline), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
  testWidgets('unavailable message follows locale changes', (tester) async {
    final locale = ValueNotifier(const Locale('en'));
    addTearDown(locale.dispose);
    await tester.pumpWidget(ProviderScope(child: ValueListenableBuilder<Locale>(
      valueListenable: locale,
      builder: (_, language, __) => MaterialApp(
        locale: language,
        supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        home: const AppShellBoundary(child: PatientDashboardScreen()),
      ),
    )));
    await tester.pumpAndSettle();
    expect(find.text('The patient dashboard is not available yet.'), findsOneWidget);
    locale.value = const Locale('fr');
    await tester.pumpAndSettle();
    expect(find.text('Le tableau de bord du patient n’est pas encore disponible.'), findsOneWidget);
    locale.value = const Locale('es');
    await tester.pumpAndSettle();
    expect(find.text('El panel del paciente aún no está disponible.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
