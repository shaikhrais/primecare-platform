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
      revenueData: dto.revenueData ?? [],
      revenueLabels: dto.revenueLabels ?? [],
      expenseData: dto.expenseData ?? [],
      expenseLabels: dto.expenseLabels ?? [],
      ebitdaTargetValue: dto.ebitda,
      ebitdaTargetMax:
          dto.ebitdaTargetMax ?? (dto.ebitda > 0 ? dto.ebitda * 1.5 : 100),
    );
  }

  static CfoDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return CfoDashboardViewModel(
      isOfflineFallback: isErrorFallback,
      kpis:
          (mock['kpis'] as List<dynamic>?)?.map((k) {
            return CfoKpi(
              title: k['title']?.toString() ?? '',
              value: k['value']?.toString() ?? '',
              trend: k['trend']?.toString() ?? '',
              status: k['status']?.toString() ?? 'operational',
            );
          }).toList() ??
          [],
      revenueData:
          (mock['revenueData'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      revenueLabels:
          (mock['revenueLabels'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      expenseData:
          (mock['expenseData'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      expenseLabels:
          (mock['expenseLabels'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      ebitdaTargetValue: (mock['ebitdaTargetValue'] as num?)?.toDouble() ?? 0,
      ebitdaTargetMax: (mock['ebitdaTargetMax'] as num?)?.toDouble() ?? 100,
    );
  }
}
