import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';
import '../core/config/api_config.dart';

final apiClient = ApiClient();

final dynamicPageProvider = FutureProvider.family<List<dynamic>, String>((
  ref,
  endpointKey,
) async {
  final path =
      ApiConfig.endpoints[endpointKey] ?? '/v1/primecare/office/$endpointKey';

  final parts = path.split('/').where((p) => p.isNotEmpty).toList();
  final dataKey = parts.last.replaceAll('-', '_');

  final response = await apiClient.get(path);
  final json = response.data;
  if (json is Map && json.containsKey(dataKey)) {
    return json[dataKey] as List<dynamic>;
  }
  return [];
});
