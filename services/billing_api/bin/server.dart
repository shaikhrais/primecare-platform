import 'package:billing_api/src/application/billing_api_host.dart';
export 'package:billing_api/src/application/billing_api_host.dart';

Future<void> main() async {
  await BillingApiHost().run();
}
