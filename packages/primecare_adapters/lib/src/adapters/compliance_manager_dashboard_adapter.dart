import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/data_source_mode.dart';
import '../config/api_config.dart';
import '../api_providers.dart';
import 'package:flutter_core/features/compliance_manager_dashboard/data/dtos/compliance_manager_dashboard_dto.dart';
import 'package:flutter_core/features/compliance_manager_dashboard/data/mappers/compliance_manager_dashboard_mapper.dart';
import 'package:flutter_core/features/compliance_manager_dashboard/domain/models/compliance_manager_dashboard_view_model.dart';

final complianceManagerDashboardAdapterProvider =
    FutureProvider.autoDispose<ComplianceManagerDashboardViewModel>((
      ref,
    ) async {
      if (DataSourceConfig.currentMode == DataSourceType.mock) {
        return ComplianceManagerDashboardMapper.toViewModel(
          const ComplianceManagerDashboardDto(rawKpis: []),
        );
      }

      try {
        final apiClient = ref.read(apiClientProvider);
        final endpoint =
            ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
        final response = await apiClient.get(
          '$endpoint?route=CorporateRoutes.complianceManagerDashboard',
        );

        if (response.statusCode == 200) {
          final dto = ComplianceManagerDashboardDto.fromJson(
            response.data as Map<String, dynamic>,
          );
          return ComplianceManagerDashboardMapper.toViewModel(dto);
        } else {
          throw Exception(
            'Failed to load compliance manager metrics: ${response.statusCode}',
          );
        }
      } catch (e) {
        if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
          return ComplianceManagerDashboardMapper.toViewModel(
            const ComplianceManagerDashboardDto(rawKpis: []),
          );
        }
        rethrow;
      }
    });
