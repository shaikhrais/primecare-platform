import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/general_manager_dashboard_view_model.dart';
import '../dtos/general_manager_dashboard_dto.dart';

class GeneralManagerDashboardMapper {
  static GeneralManagerDashboardViewModel fromApi(
    GeneralManagerDashboardDto dto,
  ) {
    return GeneralManagerDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: dto.rawKpis.map((k) => UniversalKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList())]);
  }

  static GeneralManagerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return GeneralManagerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
