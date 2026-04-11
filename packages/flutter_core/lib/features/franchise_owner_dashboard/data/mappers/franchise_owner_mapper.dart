import '../../domain/models/franchise_owner_view_model.dart';
import '../dtos/franchise_owner_dto.dart';
import '../../../../src/assembly/ui_component_blueprint.dart';

class FranchiseOwnerMapper {
  static FranchiseOwnerViewModel fromApi(FranchiseOwnerDto dto) {
    return FranchiseOwnerViewModel(
      blueprints: [
        StatGridBlueprint(
          id: 'stats_primary',
          title: 'Franchise KPI Summary',
          dataPayload: dto.rawKpis
              .map(
                (k) => FranchiseKpi(
                  title: k['name'] ?? '',
                  value: k['val']?.toString() ?? '0',
                  trend: k['trend'],
                  status: k['status'] ?? 'Active',
                ),
              )
              .toList(),
        ),
        ActivityFeedBlueprint(
          id: 'activity_primary',
          title: 'Recent Franchise Activity',
          dataPayload: dto.rawActivities
              .map(
                (a) => FranchiseActivityLog(
                  title: a['msg'] ?? '',
                  timestamp: DateTime.tryParse(a['time'] ?? '') ?? DateTime.now(),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  static FranchiseOwnerViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return FranchiseOwnerViewModel(
      isOfflineFallback: isErrorFallback,
      blueprints: [
        StatGridBlueprint(
          id: 'stats_primary',
          title: 'Franchise KPI Summary',
          dataPayload: const [
            FranchiseKpi(title: 'Total Revenue', value: '\$142,000', trend: '+5%', status: 'Active'),
            FranchiseKpi(title: 'Active Caregivers', value: '45', trend: 'Stable', status: 'Active'),
            FranchiseKpi(title: 'Client Satisfaction', value: '98%', trend: '+1%', status: 'Active'),
          ],
        ),
        ActivityFeedBlueprint(
          id: 'activity_primary',
          title: 'Recent Franchise Activity',
          dataPayload: [
            FranchiseActivityLog(
              title: 'New Client Onboarded',
              timestamp: DateTime.now().subtract(const Duration(hours: 1)),
            ),
            FranchiseActivityLog(
              title: 'Compliance Audit Passed',
              timestamp: DateTime.now().subtract(const Duration(hours: 4)),
            ),
          ],
        ),
      ],
    );
  }
}
