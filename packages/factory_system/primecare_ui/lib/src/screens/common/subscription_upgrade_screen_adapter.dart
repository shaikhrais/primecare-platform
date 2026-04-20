import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class SubscriptionUpgradeScreenViewModel {
  final bool isLoading;
  final dynamic data;
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
      state = SubscriptionUpgradeScreenViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = SubscriptionUpgradeScreenViewModel(isLoading: false, data: {});
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
