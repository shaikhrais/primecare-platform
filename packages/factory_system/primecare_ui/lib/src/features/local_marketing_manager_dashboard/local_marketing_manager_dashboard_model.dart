import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class MarketingCampaign {
  final String title;
  final String status;
  final double conversionRate;
  final double spent;

  const MarketingCampaign({
    required this.title,
    required this.status,
    required this.conversionRate,
    required this.spent,
  });
}

class ReferralSource {
  final String source;
  final int count;
  final double trend;

  const ReferralSource({
    required this.source,
    required this.count,
    required this.trend,
  });
}

class LocalMarketingManagerDashboardViewModel
    extends PrimeCareDashboardViewModel {
  final List<MarketingCampaign> campaigns;
  final List<ReferralSource> referrals;

  const LocalMarketingManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    required this.campaigns,
    required this.referrals,
    super.isOfflineFallback = false,
  });

  factory LocalMarketingManagerDashboardViewModel.empty() {
    return const LocalMarketingManagerDashboardViewModel(
      metrics: DashboardMetrics(kpis: [], recentActivity: []),
      insights: [],
      campaigns: [],
      referrals: [],
    );
  }
}
