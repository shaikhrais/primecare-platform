import '../../../../core/network/api_client.dart';
import '../../../../core/config/api_config.dart';
import '../dtos/feature_dto.dart';

class FeatureApiRepository {
  final ApiClient apiClient;

  FeatureApiRepository(this.apiClient);

  Future<List<FeatureDto>> getFeatures(String endpointKey) async {
    final path = ApiConfig.endpoints[endpointKey] ?? '/v1/office/$endpointKey';

    final parts = path.split('/').where((p) => p.isNotEmpty).toList();
    final dataKey = parts.last.replaceAll('-', '_');

    final response = await apiClient.get(path);
    final json = response.data;

    if (json is Map && json.containsKey(dataKey)) {
      final list = json[dataKey] as List<dynamic>;
      return list
          .map((item) => FeatureDto.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}

class FeatureMockRepository {
  Future<List<Map<String, dynamic>>> getMockFeatures(String endpointKey) async {
    // Generate identical mocks as backup if network utterly fails and in hybrid mode.
    // For now we leverage simple local mock representation.
    return [
      {
        'id': 'local-mock-01',
        'title': 'Local Mock Topology',
        'status': 'Offline Mock',
        'type': 'GRID',
      },
    ];
  }
}
