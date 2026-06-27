import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_payable_screen.dart';
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_receivable_screen.dart';
import 'package:primecare_corporate/features/generated_screens/cfo_financial_overview_screen.dart';
import 'package:primecare_corporate/features/generated_screens/cfo_franchise_financials_screen.dart';
import 'package:primecare_corporate/features/generated_screens/cfo_reports_screen.dart';
import 'package:primecare_corporate/features/generated_screens/cfo_tax_and_remittance_screen.dart';

Widget wrapWithHarness(Widget screen) {
  return ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppShellBoundary(
        child: screen,
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

  group('Corporate CFO Screens Visual Previews', () {
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

    testWidgets('cfo_accounts_payable', (tester) async {
      await runHarnessTest(tester, const CfoAccountsPayableScreen(), 'cfo_accounts_payable', CfoAccountsPayableScreen);
    });

    testWidgets('cfo_accounts_receivable', (tester) async {
      await runHarnessTest(tester, const CfoAccountsReceivableScreen(), 'cfo_accounts_receivable', CfoAccountsReceivableScreen);
    });

    testWidgets('cfo_financial_overview', (tester) async {
      await runHarnessTest(tester, const CfoFinancialOverviewScreen(), 'cfo_financial_overview', CfoFinancialOverviewScreen);
    });

    testWidgets('cfo_franchise_financials', (tester) async {
      await runHarnessTest(tester, const CfoFranchiseFinancialsScreen(), 'cfo_franchise_financials', CfoFranchiseFinancialsScreen);
    });

    testWidgets('cfo_reports', (tester) async {
      await runHarnessTest(tester, const CfoReportsScreen(), 'cfo_reports', CfoReportsScreen);
    });

    testWidgets('cfo_tax_and_remittance', (tester) async {
      await runHarnessTest(tester, const CfoTaxAndRemittanceScreen(), 'cfo_tax_and_remittance', CfoTaxAndRemittanceScreen);
    });
  });
}
