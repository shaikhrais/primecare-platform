import '../../domain/models/cfo_dashboard_view_model.dart';
import '../dtos/cfo_dashboard_dto.dart';

class CfoDashboardMapper {
  static CfoDashboardViewModel fromApi(CfoDashboardDto dto) {
    return CfoDashboardViewModel(
      kpis: [
        CfoKpi(
          title: 'EBITDA (QTD)',
          value: '\$${dto.ebitda.toStringAsFixed(2)}M',
          trend: '+5%',
          status: 'positive',
        ),
        CfoKpi(
          title: 'Cash Flow',
          value: '\$${dto.cashFlow.toStringAsFixed(2)}M',
          trend: '+2%',
          status: 'positive',
        ),
        CfoKpi(
          title: 'Operating Margin',
          value: '${dto.operatingMargin.toStringAsFixed(1)}%',
          trend: '-0.3%',
          status: 'warning',
        ),
        CfoKpi(
          title: 'Accounts Receivable',
          value: '\$${dto.accountsReceivable.toStringAsFixed(2)}M',
          trend: '-1.5%',
          status: 'positive',
        ),
      ],
    );
  }

  static CfoDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return CfoDashboardViewModel(
      kpis: (mock['kpis'] as List<dynamic>?)?.map((k) {
        return CfoKpi(
          title: k['title']?.toString() ?? '',
          value: k['value']?.toString() ?? '',
          trend: k['trend']?.toString() ?? '',
          status: k['status']?.toString() ?? 'operational',
        );
      }).toList() ?? [],
    );
  }
}
