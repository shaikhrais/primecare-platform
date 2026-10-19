import 'package:auth_api/src/application/auth_api_host.dart';
export 'package:auth_api/src/application/auth_api_host.dart';

Future<void> main() async {
  await AuthApiHost().run();
}
