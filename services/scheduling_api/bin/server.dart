import 'package:scheduling_api/src/application/scheduling_api_host.dart';
export 'package:scheduling_api/src/application/scheduling_api_host.dart';

Future<void> main() async {
  await SchedulingApiHost().run();
}
