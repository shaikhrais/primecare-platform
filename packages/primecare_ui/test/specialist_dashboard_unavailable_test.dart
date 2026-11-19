import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_design_test.dart' show localized;
import 'package:primecare_ui/src/screens/clinical/pediatric_dashboard/pediatric_dashboard_controller.dart';
import 'package:primecare_ui/src/screens/clinical/pediatric_dashboard/pediatric_dashboard_screen.dart';
import 'package:primecare_ui/src/screens/clinical/cns_dashboard/cns_dashboard_controller.dart';
import 'package:primecare_ui/src/screens/clinical/cns_dashboard/cns_dashboard_screen.dart';
import 'package:primecare_ui/src/screens/clinical/hsw_dashboard/hsw_dashboard_controller.dart';
import 'package:primecare_ui/src/screens/clinical/hsw_dashboard/hsw_dashboard_screen.dart';
import 'package:primecare_ui/src/screens/clinical/lpn_dashboard/lpn_dashboard_controller.dart';
import 'package:primecare_ui/src/screens/clinical/lpn_dashboard/lpn_dashboard_screen.dart';
import 'package:primecare_ui/src/screens/clinical/np_dashboard/np_dashboard_controller.dart';
import 'package:primecare_ui/src/screens/clinical/np_dashboard/np_dashboard_screen.dart';
import 'package:primecare_ui/src/screens/clinical/physician_dashboard/physician_dashboard_controller.dart';
import 'package:primecare_ui/src/screens/clinical/physician_dashboard/physician_dashboard_screen.dart';
import 'package:primecare_ui/src/screens/allied/rmt_dashboard/rmt_dashboard_controller.dart';
import 'package:primecare_ui/src/screens/allied/rmt_dashboard/rmt_dashboard_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  test('pediatric initial, reload and sync never fabricate metrics', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(
      pediatricDashboardControllerProvider.notifier,
    );
    void expectUnavailable() {
      final state = container.read(pediatricDashboardControllerProvider);
      expect(state.isLoading, isFalse);
      expect(state.error, 'workspace.unconnected');
      expect(state.data, isEmpty);
    }

    expectUnavailable();
    await controller.loadDashboardData();
    expectUnavailable();
    await controller.syncData();
    expectUnavailable();
    // A prior delayed simulation must not replace the unavailable state.
    await Future<void>.delayed(const Duration(milliseconds: 550));
    expectUnavailable();
  });

  test('cns initial, reload and sync never fabricate metrics', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(cnsDashboardControllerProvider.notifier);
    void expectUnavailable() {
      final state = container.read(cnsDashboardControllerProvider);
      expect(state.isLoading, isFalse);
      expect(state.error, 'workspace.unconnected');
      expect(state.data, isEmpty);
    }

    expectUnavailable();
    await controller.loadDashboardData();
    expectUnavailable();
    await controller.syncData();
    expectUnavailable();
    // A prior delayed simulation must not replace the unavailable state.
    await Future<void>.delayed(const Duration(milliseconds: 550));
    expectUnavailable();
  });

  test('hsw initial, reload and sync never fabricate metrics', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(hswDashboardControllerProvider.notifier);
    void expectUnavailable() {
      final state = container.read(hswDashboardControllerProvider);
      expect(state.isLoading, isFalse);
      expect(state.error, 'workspace.unconnected');
      expect(state.data, isEmpty);
    }

    expectUnavailable();
    await controller.loadDashboardData();
    expectUnavailable();
    await controller.syncData();
    expectUnavailable();
    // A prior delayed simulation must not replace the unavailable state.
    await Future<void>.delayed(const Duration(milliseconds: 550));
    expectUnavailable();
  });

  test('lpn initial, reload and sync never fabricate metrics', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(lpnDashboardControllerProvider.notifier);
    void expectUnavailable() {
      final state = container.read(lpnDashboardControllerProvider);
      expect(state.isLoading, isFalse);
      expect(state.error, 'workspace.unconnected');
      expect(state.data, isEmpty);
    }

    expectUnavailable();
    await controller.loadDashboardData();
    expectUnavailable();
    await controller.syncData();
    expectUnavailable();
    // A prior delayed simulation must not replace the unavailable state.
    await Future<void>.delayed(const Duration(milliseconds: 550));
    expectUnavailable();
  });

  test('np initial, reload and sync never fabricate metrics', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(npDashboardControllerProvider.notifier);
    void expectUnavailable() {
      final state = container.read(npDashboardControllerProvider);
      expect(state.isLoading, isFalse);
      expect(state.error, 'workspace.unconnected');
      expect(state.data, isEmpty);
    }

    expectUnavailable();
    await controller.loadDashboardData();
    expectUnavailable();
    await controller.syncData();
    expectUnavailable();
    // A prior delayed simulation must not replace the unavailable state.
    await Future<void>.delayed(const Duration(milliseconds: 550));
    expectUnavailable();
  });

  test('physician initial, reload and sync never fabricate metrics', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(
      physicianDashboardControllerProvider.notifier,
    );
    void expectUnavailable() {
      final state = container.read(physicianDashboardControllerProvider);
      expect(state.isLoading, isFalse);
      expect(state.error, 'workspace.unconnected');
      expect(state.data, isEmpty);
    }

    expectUnavailable();
    await controller.loadDashboardData();
    expectUnavailable();
    await controller.syncData();
    expectUnavailable();
    // A prior delayed simulation must not replace the unavailable state.
    await Future<void>.delayed(const Duration(milliseconds: 550));
    expectUnavailable();
  });

  test('rmt initial, reload and sync never fabricate metrics', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(rmtDashboardControllerProvider.notifier);
    void expectUnavailable() {
      final state = container.read(rmtDashboardControllerProvider);
      expect(state.isLoading, isFalse);
      expect(state.error, 'workspace.unconnected');
      expect(state.data, isEmpty);
    }

    expectUnavailable();
    await controller.loadDashboardData();
    expectUnavailable();
    await controller.syncData();
    expectUnavailable();
    // A prior delayed simulation must not replace the unavailable state.
    await Future<void>.delayed(const Duration(milliseconds: 550));
    expectUnavailable();
  });

  const messages = {
    'en': 'Data source unavailable',
    'fr': 'Source de données indisponible',
    'es': 'Fuente de datos no disponible',
  };
  final screens = <String, Widget>{
    'pediatric': const PediatricDashboardScreen(),
    'cns': const CnsDashboardScreen(),
    'hsw': const HswDashboardScreen(),
    'lpn': const LpnDashboardScreen(),
    'np': const NpDashboardScreen(),
    'physician': const PhysicianDashboardScreen(),
    'rmt': const RmtDashboardScreen(),
  };
  for (final entry in screens.entries) {
    for (final language in messages.keys) {
      testWidgets(
        '${entry.key} shows localized unavailable with no fake controls ($language)',
        (tester) async {
          final semantics = tester.ensureSemantics();
          addTearDown(semantics.dispose);
          await tester.pumpWidget(
            ProviderScope(child: localized(entry.value, language: language)),
          );
          await tester.pumpAndSettle();
          expect(find.text(messages[language]!), findsOneWidget);
          expect(
            find.byKey(ValueKey('${entry.key}dashboard_screen')),
            findsOneWidget,
          );
          // Flutter can merge route labels with descendant text. Match a
          // complete label line in the actual accessibility tree.
          expect(
            find.semantics.byLabel(RegExp(r'(?:^|\n)screen-root(?:\n|$)')),
            findsOneWidget,
          );
          expect(
            find.semantics.byLabel(RegExp(r'(?:^|\n)page-title(?:\n|$)')),
            findsOneWidget,
          );
          expect(
            find.semantics.byLabel(RegExp(RegExp.escape(messages[language]!))),
            findsOneWidget,
          );
          expect(find.byType(Card), findsNothing);
          expect(find.byType(ElevatedButton), findsNothing);
          expect(find.byIcon(Icons.sync), findsNothing);
          expect(find.byType(CircularProgressIndicator), findsNothing);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}
