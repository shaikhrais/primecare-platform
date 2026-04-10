import '../../domain/models/regional_manager_usa_dashboard_view_model.dart';
import '../dtos/regional_manager_usa_dashboard_dto.dart';

class RegionalManagerUsaDashboardMapper {
  static RegionalManagerUsaDashboardViewModel toViewModel(RegionalManagerUsaDashboardDto dto) {
    if (dto.rawKpis.isEmpty) {
      return RegionalManagerUsaDashboardViewModel(kpis: _mockKpis());
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return RegionalUsaKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return RegionalManagerUsaDashboardViewModel(kpis: kpis);
  }

  static List<RegionalUsaKpi> _mockKpis() {
    return [
      const RegionalUsaKpi(title: 'USA Revenue (Q1)', value: '\$24.1M', trend: '+8%', status: 'Operational'),
      const RegionalUsaKpi(title: 'Active Facilities (US)', value: '112', trend: '+5', status: 'Operational'),
      const RegionalUsaKpi(title: 'Regional Staff (US)', value: '2,300', trend: '+2%', status: 'Operational'),
      const RegionalUsaKpi(title: 'Open Cases (US)', value: '540', trend: '-2%', status: 'Operational'),
    ];
  }
}
