import 'package:governance_api/src/application/governance_api_host.dart';
export 'package:governance_api/src/application/governance_api_host.dart';

Future<void> main(List<String> args) async {
  await GovernanceApiHost().run();
}
