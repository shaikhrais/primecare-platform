import '../../../../flutter_core.dart';
import '../../domain/repositories/territory_sales_manager_repository.dart';
import '../view_models/territory_sales_manager_notifier.dart';

final Provider<ITerritorySalesManagerRepository>
territorySalesManagerRepositoryProvider =
    Provider<ITerritorySalesManagerRepository>((Ref ref) {
      return TerritorySalesManagerRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<
  TerritorySalesManagerNotifier,
  AsyncValue<TerritorySalesManagerDashboardViewModel>
>
territorySalesManagerDashboardProvider =
    NotifierProvider<
      TerritorySalesManagerNotifier,
      AsyncValue<TerritorySalesManagerDashboardViewModel>
    >(TerritorySalesManagerNotifier.new);
