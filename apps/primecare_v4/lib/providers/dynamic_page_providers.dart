
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_client.dart';
import '../../core/config/api_config.dart';

// Dynamically generated providers for UI endpoints
final dynamicPageProvider = FutureProvider.family<List<dynamic>, String>((ref, endpointKey) async {
  final path = ApiConfig.endpoints[endpointKey];
  if (path == null) throw Exception('Endpoint $endpointKey not found in registry');
  
  // Extract identifier. e.g. /v1/office/dashboard/deals -> deals
  final parts = path.split('/').where((p) => p.isNotEmpty).toList();
  final dataKey = parts.last.replaceAll('-', '_');

  final json = await apiClient.get(path);
  if (json is Map && json.containsKey(dataKey)) {
    return json[dataKey] as List<dynamic>;
  }
  return [];
});
