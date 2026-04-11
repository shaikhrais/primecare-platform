import '../../domain/models/general_manager_dashboard_view_model.dart';
import '../dtos/general_manager_dashboard_dto.dart';
import '../mappers/general_manager_dashboard_mapper.dart';
import '../../../../network/api_client.dart';
import '../../../../config/api_config.dart';
import '../../../../config/data_source_mode.dart';

class GeneralManagerDashboardAdapter {
  final ApiClient _apiClient;

  GeneralManagerDashboardAdapter(this._apiClient);

  Future<GeneralManagerDashboardViewModel> getData(String endpointKey) async {
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
          final dto = GeneralManagerDashboardDto.fromJson(json);
          return GeneralManagerDashboardMapper.fromApi(dto);
        }
      }
      throw Exception('Failed to load: ${response.statusCode}');
    } catch (e) {
      if (DataSourceConfig.currentMode == DataSourceType.hybrid ||
          DataSourceConfig.currentMode == DataSourceType.mock) {
        return GeneralManagerDashboardMapper.fromMock({});
      }
      rethrow;
    }
  }
}
