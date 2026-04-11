import '../../domain/models/hr_hiring_dashboard_view_model.dart';
import '../dtos/hr_hiring_dashboard_dto.dart';
import '../mappers/hr_hiring_dashboard_mapper.dart';
import '../../../../network/api_client.dart';
import '../../../../config/api_config.dart';
import '../../../../config/data_source_mode.dart';

class HrHiringDashboardAdapter {
  final ApiClient _apiClient;

  HrHiringDashboardAdapter(this._apiClient);

  Future<HrHiringDashboardViewModel> getData(String endpointKey) async {
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
          final dto = HrHiringDashboardDto.fromJson(json);
          return HrHiringDashboardMapper.fromApi(dto);
        }
      }
      throw Exception('Failed to load: ${response.statusCode}');
    } catch (e) {
      if (DataSourceConfig.currentMode == DataSourceType.hybrid ||
          DataSourceConfig.currentMode == DataSourceType.mock) {
        return HrHiringDashboardMapper.fromMock({});
      }
      rethrow;
    }
  }
}
