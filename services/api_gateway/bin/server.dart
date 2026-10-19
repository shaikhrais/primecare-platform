import 'package:api_gateway/src/application/api_gateway_host.dart';
export 'package:api_gateway/src/application/api_gateway_host.dart';

Future<void> main() async {
  await ApiGatewayHost().run();
}
