// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_territory_sales_manager_repository.dart';
import '../view_models/04_V_territory_sales_manager_notifier.dart';

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
