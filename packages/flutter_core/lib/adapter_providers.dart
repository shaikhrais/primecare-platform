import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeatureViewModel {
  final String id;
  final String title;
  final String description;
  final String status;
  
  FeatureViewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });
}

class ProviderDashboardAdapter {
  const ProviderDashboardAdapter();
}

class ClientProfileAdapter {
  const ClientProfileAdapter();
}

class VisitDetailsAdapter {
  const VisitDetailsAdapter();
}

class BillingSummaryAdapter {
  const BillingSummaryAdapter();
}

class FeatureAdapter {
  const FeatureAdapter();
  Future<List<FeatureViewModel>> getData(String endpointKey) async => [];
}


final providerDashboardAdapterProvider = Provider<ProviderDashboardAdapter>((ref) => const ProviderDashboardAdapter());
final clientProfileAdapterProvider = Provider<ClientProfileAdapter>((ref) => const ClientProfileAdapter());
final visitDetailsAdapterProvider = Provider<VisitDetailsAdapter>((ref) => const VisitDetailsAdapter());
final billingSummaryAdapterProvider = Provider<BillingSummaryAdapter>((ref) => const BillingSummaryAdapter());

class SubscriptionUpgradeAdapter {
  const SubscriptionUpgradeAdapter();
  // Any UI-specific mappings for the promo code screen would go here.
}

final subscriptionUpgradeAdapterProvider = Provider<SubscriptionUpgradeAdapter>((ref) => const SubscriptionUpgradeAdapter());


final adapterFeatureDataProvider =
    FutureProvider.family<List<FeatureViewModel>, String>((
      ref,
      endpointKey,
    ) async {
      return [];
    });

