import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';

import '../features/generic_feature/data/repositories/feature_repository.dart';
import '../features/generic_feature/data/adapters/feature_adapter.dart';
import '../features/generic_feature/domain/models/feature_view_model.dart';

import '../features/provider_dashboard/data/adapters/provider_dashboard_adapter.dart';
import '../features/client_profile/data/adapters/client_profile_adapter.dart';
import '../features/visit_details/data/adapters/visit_details_adapter.dart';
import '../features/billing_summary/data/adapters/billing_summary_adapter.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

// Specific Feature Adapters
final providerDashboardMockProvider = Provider((ref) => ProviderDashboardMockProvider());
final providerDashboardApiProvider = Provider((ref) => ProviderDashboardApiProvider(ref.watch(apiClientProvider)));

final providerDashboardAdapterProvider = Provider<ProviderDashboardAdapter>((ref) {
  return ProviderDashboardAdapter(
    mockProvider: ref.watch(providerDashboardMockProvider),
    apiProvider: ref.watch(providerDashboardApiProvider),
  );
});

final clientProfileMockProvider = Provider((ref) => ClientProfileMockProvider());
final clientProfileApiProvider = Provider((ref) => ClientProfileApiProvider(ref.watch(apiClientProvider)));
final clientProfileAdapterProvider = Provider<ClientProfileAdapter>((ref) {
  return ClientProfileAdapter(
    mockProvider: ref.watch(clientProfileMockProvider),
    apiProvider: ref.watch(clientProfileApiProvider),
  );
});

final visitDetailsMockProvider = Provider((ref) => VisitDetailsMockProvider());
final visitDetailsApiProvider = Provider((ref) => VisitDetailsApiProvider(ref.watch(apiClientProvider)));
final visitDetailsAdapterProvider = Provider<VisitDetailsAdapter>((ref) {
  return VisitDetailsAdapter(
    mockProvider: ref.watch(visitDetailsMockProvider),
    apiProvider: ref.watch(visitDetailsApiProvider),
  );
});

final billingSummaryMockProvider = Provider((ref) => BillingSummaryMockProvider());
final billingSummaryApiProvider = Provider((ref) => BillingSummaryApiProvider(ref.watch(apiClientProvider)));
final billingSummaryAdapterProvider = Provider<BillingSummaryAdapter>((ref) {
  return BillingSummaryAdapter(
    mockProvider: ref.watch(billingSummaryMockProvider),
    apiProvider: ref.watch(billingSummaryApiProvider),
  );
});

// Generic Master Registry Feature Adapters (110 Screen Support)
final featureApiRepositoryProvider = Provider<FeatureApiRepository>((ref) => FeatureApiRepository(ref.watch(apiClientProvider)));
final featureMockRepositoryProvider = Provider<FeatureMockRepository>((ref) => FeatureMockRepository());

final featureAdapterProvider = Provider<FeatureAdapter>((ref) {
  return FeatureAdapter(
    apiRepository: ref.watch(featureApiRepositoryProvider),
    mockRepository: ref.watch(featureMockRepositoryProvider),
  );
});

final adapterFeatureDataProvider = FutureProvider.family<List<FeatureViewModel>, String>((ref, endpointKey) async {
  final adapter = ref.watch(featureAdapterProvider);
  return adapter.getData(endpointKey);
});
