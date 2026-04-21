// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_territory_expansion_manager_repository.dart';
import '../view_models/04_V_territory_expansion_manager_notifier.dart';

final Provider<ITerritoryExpansionManagerRepository>
territoryExpansionManagerRepositoryProvider =
    Provider<ITerritoryExpansionManagerRepository>((Ref ref) {
      return TerritoryExpansionManagerRepository(
        ref.watch(domainServiceProvider),
      );
    });

final NotifierProvider<
  TerritoryExpansionManagerNotifier,
  AsyncValue<TerritoryExpansionManagerDashboardViewModel>
>
territoryExpansionManagerDashboardProvider =
    NotifierProvider<
      TerritoryExpansionManagerNotifier,
      AsyncValue<TerritoryExpansionManagerDashboardViewModel>
    >(TerritoryExpansionManagerNotifier.new);
