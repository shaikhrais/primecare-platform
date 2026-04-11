import '../../domain/models/customer_support_dashboard_view_model.dart';
import '../dtos/customer_support_dashboard_dto.dart';
import '../mappers/customer_support_dashboard_mapper.dart';
import '../../../../network/api_client.dart';
import '../../../../config/api_config.dart';
import '../../../../config/data_source_mode.dart';

class CustomerSupportDashboardAdapter {
  final ApiClient _apiClient;

  CustomerSupportDashboardAdapter(this._apiClient);

  Future<CustomerSupportDashboardViewModel> getData(String endpointKey) async {
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
          final dto = CustomerSupportDashboardDto.fromJson(json);
          return CustomerSupportDashboardMapper.fromApi(dto);
        }
      }
      throw Exception('Failed to load: ${response.statusCode}');
    } catch (e) {
      if (DataSourceConfig.currentMode == DataSourceType.hybrid ||
          DataSourceConfig.currentMode == DataSourceType.mock) {
        return CustomerSupportDashboardMapper.fromMock({});
      }
      rethrow;
    }
  }
}
