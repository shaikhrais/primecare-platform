import '../../domain/models/head_of_bus_dev_dashboard_view_model.dart';
import '../dtos/head_of_bus_dev_dashboard_dto.dart';
import '../mappers/head_of_bus_dev_dashboard_mapper.dart';
import '../../../../network/api_client.dart';
import '../../../../config/api_config.dart';
import '../../../../config/data_source_mode.dart';

class HeadOfBusDevDashboardAdapter {
  final ApiClient _apiClient;

  HeadOfBusDevDashboardAdapter(this._apiClient);

  Future<HeadOfBusDevDashboardViewModel> getData(String endpointKey) async {
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
          final dto = HeadOfBusDevDashboardDto.fromJson(json);
          return HeadOfBusDevDashboardMapper.fromApi(dto);
        }
      }
      throw Exception('Failed to load: ${response.statusCode}');
    } catch (e) {
      if (DataSourceConfig.currentMode == DataSourceType.hybrid ||
          DataSourceConfig.currentMode == DataSourceType.mock) {
        return HeadOfBusDevDashboardMapper.fromMock({});
      }
      rethrow;
    }
  }
}
