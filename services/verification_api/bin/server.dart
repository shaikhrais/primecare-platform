import 'package:verification_api/src/application/verification_api_host.dart';
export 'package:verification_api/src/application/verification_api_host.dart';

Future<void> main() async {
  await VerificationApiHost().run();
}
