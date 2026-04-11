import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/community_outreach_dashboard_view_model.dart';
import '../dtos/community_outreach_dashboard_dto.dart';

class CommunityOutreachDashboardMapper {
  static CommunityOutreachDashboardViewModel fromApi(
    CommunityOutreachDashboardDto dto,
  ) {
    return CommunityOutreachDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: dto.rawKpis.map((k) => UniversalKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList())]);
  }

  static CommunityOutreachDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return CommunityOutreachDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
