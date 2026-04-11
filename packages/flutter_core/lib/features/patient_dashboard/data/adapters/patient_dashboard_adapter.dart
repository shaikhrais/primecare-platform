import '../../domain/models/patient_dashboard_view_model.dart';
import '../dtos/patient_dashboard_dto.dart';
import '../mappers/patient_dashboard_mapper.dart';
import '../../../../network/api_client.dart';
import '../../../../config/api_config.dart';
import '../../../../config/data_source_mode.dart';

class PatientDashboardAdapter {
  final ApiClient _apiClient;

  PatientDashboardAdapter(this._apiClient);

  Future<PatientDashboardViewModel> getData(String endpointKey) async {
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
          final dto = PatientDashboardDto.fromJson(json);
          return PatientDashboardMapper.toViewModel(dto);
        }
      }
      throw Exception('Failed to load: ${response.statusCode}');
    } catch (e) {
      if (DataSourceConfig.currentMode == DataSourceType.hybrid ||
          DataSourceConfig.currentMode == DataSourceType.mock) {
        return PatientDashboardMapper.toViewModel(
          PatientDashboardDto.fromJson({}),
        );
      }
      rethrow;
    }
  }
}
