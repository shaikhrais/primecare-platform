import '../../domain/models/franchise_sales_manager_dashboard_view_model.dart';
import '../dtos/franchise_sales_manager_dashboard_dto.dart';
import '../mappers/franchise_sales_manager_dashboard_mapper.dart';
import '../../../../network/api_client.dart';
import '../../../../config/api_config.dart';
import '../../../../config/data_source_mode.dart';

class FranchiseSalesManagerDashboardAdapter {
  final ApiClient _apiClient;

  FranchiseSalesManagerDashboardAdapter(this._apiClient);

  Future<FranchiseSalesManagerDashboardViewModel> getData(
    String endpointKey,
  ) async {
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
          final dto = FranchiseSalesManagerDashboardDto.fromJson(json);
          return FranchiseSalesManagerDashboardMapper.fromApi(dto);
        }
      }
      throw Exception('Failed to load: ${response.statusCode}');
    } catch (e) {
      if (DataSourceConfig.currentMode == DataSourceType.hybrid ||
          DataSourceConfig.currentMode == DataSourceType.mock) {
        return FranchiseSalesManagerDashboardMapper.fromMock({}, isErrorFallback: true);
      }
      rethrow;
    }
  }
}
