import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class MarketingManagerViewModel {
  final int activeCampaigns;
  final int leadConversions;

  const MarketingManagerViewModel({
    required this.activeCampaigns,
    required this.leadConversions,
  });

  factory MarketingManagerViewModel.initial() {
    return const MarketingManagerViewModel(
      activeCampaigns: 12,
      leadConversions: 450,
    );
  }
}
