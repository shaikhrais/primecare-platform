import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_corporate/main.dart' as corporate;
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_corporate/core/routing/corporate_routes.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final rolesToTest = PlatformRole.values
      .where((r) => r != PlatformRole.unknown)
      .map((r) => r.nameSnake)
      .toList();

  for (final role in rolesToTest) {
    testWidgets('Stress Test Nav for $role', (WidgetTester tester) async {
      // Setup dependencies explicitly since main() hides the futures
      await EasyLocalization.ensureInitialized();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('fr'), Locale('es'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          useOnlyLangCode: true,
          child: ProviderScope(
            overrides: [
              sharedPreferencesProvider.overrideWithValue(prefs),
              platformApplicationProvider.overrideWithValue(CorporateApplication()),
            ],
            child: const corporate.PrimeCareCorporateApp(),
          ),
        ),
      );

      // Wait for app to render
      await tester.pumpAndSettle();

      // Find the email field and sign in
      final emailField = find.byType(TextField);
      expect(emailField, findsOneWidget);

      await tester.enterText(emailField, '$role@demo.primecare.com');
      await tester.pump();

      final signInBtn = find.text('Sign In');
      expect(signInBtn, findsOneWidget);

      await tester.tap(signInBtn);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Now we should be logged in and on the dashboard for that role.
      // If there is a Hamburger menu (Drawer icon), open it.
      final menuIcon = find.byIcon(Icons.menu);
      if (menuIcon.evaluate().isNotEmpty) {
        await tester.tap(menuIcon);
        await tester.pumpAndSettle();
      }

      final navItems = find.byType(ListTile);
      final navCount = tester.widgetList(navItems).length;
      
      final sidebarTitles = <String>[];

      for (int i = 0; i < navCount; i++) {
        // Re-find to avoid stale references
        final item = find.byType(ListTile).at(i);
        
        try {
          final listTileWidget = tester.widget<ListTile>(item);
          if (listTileWidget.title is Text) {
            sidebarTitles.add((listTileWidget.title as Text).data ?? 'Unknown');
          }

          await tester.ensureVisible(item);
          await tester.tap(item);
          await tester.pumpAndSettle();
        } catch (e) {
          // It might be non-tappable or out of bounds
        }
        
        // Re-open drawer if it closed
        final reMenuIcon = find.byIcon(Icons.menu);
        if (reMenuIcon.evaluate().isNotEmpty) {
          await tester.tap(reMenuIcon);
          await tester.pumpAndSettle();
        }
      }

      print('ROLE [$role] SIDEBAR ($navCount items): ${sidebarTitles.join(", ")}');

      // Assert that no unhandled exceptions crashed the app
      expect(tester.takeException(), isNull);
    });
  }
}
