import '../../../../flutter_core.dart';
import '../../domain/repositories/territory_expansion_manager_repository.dart';
import '../view_models/territory_expansion_manager_notifier.dart';

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
