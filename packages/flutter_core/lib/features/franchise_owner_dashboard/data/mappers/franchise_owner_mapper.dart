import '../../domain/models/franchise_owner_view_model.dart';
import '../dtos/franchise_owner_dto.dart';

class FranchiseOwnerMapper {
  static FranchiseOwnerViewModel fromApi(FranchiseOwnerDto dto) {
    return FranchiseOwnerViewModel(
      kpis: dto.rawKpis
          .map(
            (k) => FranchiseKpi(
              label: k['name'] ?? '',
              value: k['val']?.toString() ?? '0',
              trend: k['trend'],
            ),
          )
          .toList(),
      recentActivity: dto.rawActivities
          .map(
            (a) => FranchiseActivityLog(
              title: a['msg'] ?? '',
              timestamp: DateTime.tryParse(a['time'] ?? '') ?? DateTime.now(),
            ),
          )
          .toList(),
    );
  }

  static FranchiseOwnerViewModel fromMock(Map<String, dynamic> mock) {
    return FranchiseOwnerViewModel(
      kpis: const [
        FranchiseKpi(label: 'Total Revenue', value: '\$142,000', trend: '+5%'),
        FranchiseKpi(label: 'Active Caregivers', value: '45', trend: 'Stable'),
        FranchiseKpi(label: 'Client Satisfaction', value: '98%', trend: '+1%'),
      ],
      recentActivity: [
        FranchiseActivityLog(
          title: 'New Client Onboarded',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        FranchiseActivityLog(
          title: 'Compliance Audit Passed',
          timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        ),
      ],
    );
  }
}
