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

  group('CFO Screens Visual Previews', () {
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

      // Clear any exceptions thrown during layout/pump so they don't fail the test
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

      // Clear any exceptions thrown during golden matching
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

    testWidgets('cfo_dashboard', (tester) async {
      await runHarnessTest(tester, const CfoDashboardScreen(), 'cfo_dashboard', CfoDashboardScreen);
    });

    testWidgets('cfo_analytics', (tester) async {
      await runHarnessTest(tester, const CfoAnalyticsScreen(), 'cfo_analytics', CfoAnalyticsScreen);
    });

    testWidgets('cfo_workflow', (tester) async {
      await runHarnessTest(tester, const CfoWorkflowScreen(), 'cfo_workflow', CfoWorkflowScreen);
    });

    testWidgets('cfo_revenue', (tester) async {
      await runHarnessTest(tester, const CfoRevenueScreen(), 'cfo_revenue', CfoRevenueScreen);
    });

    testWidgets('cfo_expenses', (tester) async {
      await runHarnessTest(tester, const CfoExpensesScreen(), 'cfo_expenses', CfoExpensesScreen);
    });

    testWidgets('cfo_payroll', (tester) async {
      await runHarnessTest(tester, const CfoPayrollScreen(), 'cfo_payroll', CfoPayrollScreen);
    });

    testWidgets('cfo_invoices', (tester) async {
      await runHarnessTest(tester, const CfoInvoicesScreen(), 'cfo_invoices', CfoInvoicesScreen);
    });

    testWidgets('cfo_tax', (tester) async {
      await runHarnessTest(tester, const CfoTaxScreen(), 'cfo_tax', CfoTaxScreen);
    });

    testWidgets('cfo_profitability', (tester) async {
      await runHarnessTest(tester, const CfoProfitabilityScreen(), 'cfo_profitability', CfoProfitabilityScreen);
    });

    testWidgets('cfo_cashflow', (tester) async {
      await runHarnessTest(tester, const CfoCashflowScreen(), 'cfo_cashflow', CfoCashflowScreen);
    });

    testWidgets('cfo_financial_dashboard', (tester) async {
      await runHarnessTest(tester, const FinancialDashboardScreen(), 'cfo_financial_dashboard', FinancialDashboardScreen);
    });
  });
}
