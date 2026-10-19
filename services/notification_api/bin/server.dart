import 'package:notification_api/src/application/notification_api_host.dart';
export 'package:notification_api/src/application/notification_api_host.dart';

Future<void> main() async {
  await NotificationApiHost().run();
}
