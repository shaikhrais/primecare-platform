// Layer: 05_UI_PRESENTATION
import 'package:flutter_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class SubscriptionUpgradeScreenViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  SubscriptionUpgradeScreenViewModel({this.isLoading = false, this.data});
}

class SubscriptionUpgradeScreenAdapter
    extends Notifier<SubscriptionUpgradeScreenViewModel> {
  @override
  SubscriptionUpgradeScreenViewModel build() {
    return SubscriptionUpgradeScreenViewModel();
  }

  Future<void> loadData() async {
        state = SubscriptionUpgradeScreenViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/subscription-upgrade-screen-adapter');
      state = SubscriptionUpgradeScreenViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = SubscriptionUpgradeScreenViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final subscriptionUpgradeScreenAdapterProvider =
    NotifierProvider<
      SubscriptionUpgradeScreenAdapter,
      SubscriptionUpgradeScreenViewModel
    >(() {
      return SubscriptionUpgradeScreenAdapter();
    });
