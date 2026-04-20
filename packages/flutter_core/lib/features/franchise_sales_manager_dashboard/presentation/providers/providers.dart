import '../../../../flutter_core.dart';
import '../../domain/repositories/franchise_sales_manager_repository.dart';
import '../view_models/franchise_sales_manager_notifier.dart';

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
