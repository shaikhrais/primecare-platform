// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_franchise_refunds_repository.dart';
import '../view_models/04_V_franchise_refunds_notifier.dart';

final franchiseRefundsRepositoryProvider =
    Provider<IFranchiseRefundsRepository>((ref) {
      return FranchiseRefundsRepository(ref.watch(dashboardServiceProvider));
    });

final franchiseRefundsNotifierProvider =
    NotifierProvider<
      FranchiseRefundsNotifier,
      AsyncValue<FranchiseRefundsDashboardViewModel>
    >(FranchiseRefundsNotifier.new);
