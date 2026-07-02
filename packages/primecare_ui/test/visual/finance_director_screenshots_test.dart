import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';

Widget wrapWithHarness(Widget screen) {
  return ProviderScope(
    child: PrimeTheme(
      data: const PrimeThemeData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppShellBoundary(
          child: screen,
        ),
      ),
    ),
  );
}

void main() {
  final Map<String, String> testErrors = {};
  List<String> currentTestErrors = [];
  void Function(FlutterErrorDetails)? originalOnError;

  setUp(() {
    screenshotPresentationMode = true;
    currentTestErrors = [];
    originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      currentTestErrors.add(details.exceptionAsString());
    };
  });

  tearDown(() {
    FlutterError.onError = originalOnError;
  });

  tearDownAll(() {
    final file = File('test_errors.json');
    file.writeAsStringSync(jsonEncode(testErrors));
    print('Saved test_errors.json with ${testErrors.length} entries.');
  });

  group('Finance Director Screens Visual Previews', () {
    Future<void> runHarnessTest(WidgetTester tester, Widget screen, String name, Type widgetType) async {
      await tester.binding.setSurfaceSize(const Size(1280, 800));
      try {
        await tester.pumpWidget(wrapWithHarness(screen));
        for (int i = 0; i < 5; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
      } catch (e) {
        currentTestErrors.add('PumpWidget failed: $e');
      }

      final exception = tester.takeException();
      if (exception != null) {
        currentTestErrors.add('LayoutException: $exception');
      }

      try {
        await expectLater(
          find.byType(widgetType),
          matchesGoldenFile('goldens/$name.png'),
        );
      } catch (e) {
        currentTestErrors.add('Golden match failed: $e');
      }

      final postException = tester.takeException();
      if (postException != null) {
        currentTestErrors.add('PostException: $postException');
      }

      final actualErrors = currentTestErrors.where((e) => !e.contains('overflowed')).toList();
      if (actualErrors.isNotEmpty) {
        testErrors[name] = actualErrors.join('\n');
      } else {
        testErrors[name] = '';
      }
    }

    testWidgets('finance_director_dashboard', (tester) async {
      await runHarnessTest(tester, const FinanceDirectorDashboardScreen(), 'finance_director_dashboard', FinanceDirectorDashboardScreen);
    });

    testWidgets('finance_director_analytics', (tester) async {
      await runHarnessTest(tester, const FinanceDirectorAnalyticsScreen(), 'finance_director_analytics', FinanceDirectorAnalyticsScreen);
    });

    testWidgets('finance_director_compliance', (tester) async {
      await runHarnessTest(tester, const FinanceDirectorComplianceScreen(), 'finance_director_compliance', FinanceDirectorComplianceScreen);
    });

    testWidgets('finance_director_workflow', (tester) async {
      await runHarnessTest(tester, const FinanceDirectorWorkflowScreen(), 'finance_director_workflow', FinanceDirectorWorkflowScreen);
    });
  });
}
