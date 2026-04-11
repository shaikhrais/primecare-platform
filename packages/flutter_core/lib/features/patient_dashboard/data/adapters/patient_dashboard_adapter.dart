import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/data_source_mode.dart';
import '../../../../config/api_config.dart';
import '../../../../api_providers.dart';
import '../dtos/patient_dashboard_dto.dart';
import '../mappers/patient_dashboard_mapper.dart';
import '../../domain/models/patient_dashboard_view_model.dart';

final patientDashboardAdapterProvider =
    FutureProvider.autoDispose<PatientDashboardViewModel>((ref) async {
      if (DataSourceConfig.currentMode == DataSourceType.mock) {
        return PatientDashboardMapper.toViewModel(
          const PatientDashboardDto(rawKpis: []),
        );
      }

      try {
        final apiClient = ref.read(apiClientProvider);
        final endpoint =
            ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
        final response = await apiClient.get(
          '$endpoint?route=CorporateRoutes.patientDashboard',
        );

        if (response.statusCode == 200) {
          final dto = PatientDashboardDto.fromJson(
            response.data as Map<String, dynamic>,
          );
          return PatientDashboardMapper.toViewModel(dto);
        } else {
          throw Exception(
            'Failed to load patient metrics: ${response.statusCode}',
          );
        }
      } catch (e) {
        if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
          return PatientDashboardMapper.toViewModel(
            const PatientDashboardDto(rawKpis: []),
          );
        }
        rethrow;
      }
    });
