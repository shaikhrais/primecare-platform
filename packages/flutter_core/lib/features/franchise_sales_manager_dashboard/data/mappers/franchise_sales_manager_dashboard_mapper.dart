import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/franchise_sales_manager_dashboard_view_model.dart';
import '../dtos/franchise_sales_manager_dashboard_dto.dart';

class FranchiseSalesManagerDashboardMapper {
  static FranchiseSalesManagerDashboardViewModel fromApi(
    FranchiseSalesManagerDashboardDto dto,
  ) {
    return FranchiseSalesManagerDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: dto.rawKpis.map((k) => UniversalKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList())]);
  }

  static FranchiseSalesManagerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return FranchiseSalesManagerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
