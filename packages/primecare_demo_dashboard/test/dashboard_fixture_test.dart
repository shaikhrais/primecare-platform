import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_demo_dashboard/primecare_demo_dashboard.dart';
void main() { test('simulated metrics source returns a fixture', () async { final result=await DashboardService().getMetrics('fixture');expect(result.getOrThrow(),isNotNull); }); }
