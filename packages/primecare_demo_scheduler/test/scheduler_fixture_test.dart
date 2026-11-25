import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_demo_scheduler/primecare_demo_scheduler.dart';
void main() { test('existing bootstrap simulation returns a schedule', () async { final result=await SchedulerService().getHorizonSchedule();expect(result.getOrThrow().staff,isNotEmpty); }); }
