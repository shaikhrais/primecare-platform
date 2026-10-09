import 'package:compliance_api/src/application/compliance_api_host.dart';
export 'package:compliance_api/src/application/compliance_api_host.dart';

Future<void> main() async {
  await ComplianceApiHost().run();
}
