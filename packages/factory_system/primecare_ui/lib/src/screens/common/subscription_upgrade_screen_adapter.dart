import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class SubscriptionUpgradeScreenViewModel {
  final bool isLoading;
  final dynamic data;
  SubscriptionUpgradeScreenViewModel({this.isLoading = false, this.data});
}

class SubscriptionUpgradeScreenAdapter extends Notifier<SubscriptionUpgradeScreenViewModel> {
  @override
  SubscriptionUpgradeScreenViewModel build() {
    return SubscriptionUpgradeScreenViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = SubscriptionUpgradeScreenViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = SubscriptionUpgradeScreenViewModel(isLoading: false, data: {});
  }
}

final subscriptionUpgradeScreenAdapterProvider = NotifierProvider<SubscriptionUpgradeScreenAdapter, SubscriptionUpgradeScreenViewModel>(() {
  return SubscriptionUpgradeScreenAdapter();
});
