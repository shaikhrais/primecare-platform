// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_franchise_sales_manager_repository.dart';
import '../view_models/04_V_franchise_sales_manager_notifier.dart';

final Provider<IFranchiseSalesManagerRepository>
franchiseSalesManagerRepositoryProvider =
    Provider<IFranchiseSalesManagerRepository>((Ref ref) {
      return FranchiseSalesManagerRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<
  FranchiseSalesManagerNotifier,
  AsyncValue<FranchiseSalesManagerDashboardViewModel>
>
franchiseSalesManagerDashboardProvider =
    NotifierProvider<
      FranchiseSalesManagerNotifier,
      AsyncValue<FranchiseSalesManagerDashboardViewModel>
    >(FranchiseSalesManagerNotifier.new);
