// Host supplies the original authenticated API transport.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_psw/src/services/psw_service.dart';
import '../network/api_client.dart';

class PswService extends PswServiceBase {
  PswService(ApiClient api) : super((path) async => (await api.get(path)).data);
}

final pswServiceProvider = Provider<PswService>((ref) {
  final api = ref.watch(apiClientProvider);
  return PswService(api);
});
