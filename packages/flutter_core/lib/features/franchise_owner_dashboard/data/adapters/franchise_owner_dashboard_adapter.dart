import '../../domain/models/franchise_owner_view_model.dart';
import '../dtos/franchise_owner_dto.dart';
import '../mappers/franchise_owner_mapper.dart';
import '../../../../network/api_client.dart';
import '../../../../config/api_config.dart';
import '../../../../config/data_source_mode.dart';

class FranchiseOwnerDashboardAdapter {
  final ApiClient _apiClient;

  FranchiseOwnerDashboardAdapter(this._apiClient);

  Future<FranchiseOwnerViewModel> getData(String endpointKey) async {
    try {
      final path =
          ApiConfig.endpoints[endpointKey] ??
          '/v1/primecare/office/$endpointKey';
      final response = await _apiClient.get(path);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          final parts = path.split('/').where((p) => p.isNotEmpty).toList();
          final dataKey = parts.isNotEmpty
              ? parts.last.replaceAll('-', '_')
              : '';

          Map<String, dynamic> json = data;
          if (dataKey.isNotEmpty && data.containsKey(dataKey)) {
            json = data[dataKey] as Map<String, dynamic>;
          }
          final dto = FranchiseOwnerDto.fromJson(json);
          return FranchiseOwnerMapper.fromApi(dto);
        }
      }
      throw Exception('Failed to load: ${response.statusCode}');
    } catch (e) {
      if (DataSourceConfig.currentMode == DataSourceType.hybrid ||
          DataSourceConfig.currentMode == DataSourceType.mock) {
        return FranchiseOwnerMapper.fromApi(FranchiseOwnerDto.fromJson({}));
      }
      rethrow;
    }
  }
}
