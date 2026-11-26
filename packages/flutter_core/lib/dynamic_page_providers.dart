// Host retains the existing authenticated API client and endpoint configuration.
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_dynamic_pages/dynamic_page_providers.dart';

final dynamicPageProvider =
  FutureProvider.family<Result<List<dynamic>>, String>((ref, endpointKey) {
    final apiClient = ref.watch(apiClientProvider);
    return loadDynamicPage(ref, endpointKey,
      (key) => ApiConfig.endpoints[key],
      (path) async => (await apiClient.get(path)).data);
  });
