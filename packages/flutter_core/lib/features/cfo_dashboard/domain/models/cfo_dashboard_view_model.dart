import '../../../../config/offline_fallback_state.dart';
class CfoDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<CfoKpi> kpis;
  final List<double> revenueData;
  final List<String> revenueLabels;
  final List<double> expenseData;
  final List<String> expenseLabels;
  final double ebitdaTargetValue;
  final double ebitdaTargetMax;

  const CfoDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.revenueData = const [],
    this.revenueLabels = const [],
    this.expenseData = const [],
    this.expenseLabels = const [],
    this.ebitdaTargetValue = 0,
    this.ebitdaTargetMax = 0,
   this.recentActivity = const [],});
}

class CfoKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const CfoKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class CfoDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const CfoDashboardKpi({this.title, this.value, this.trend, this.status});
}

class CfoDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const CfoDashboardActivity({this.title, this.subtitle, this.timestamp});
}
