import '../../../../flutter_core.dart';
import '../../domain/repositories/franchise_refunds_repository.dart';
import '../view_models/franchise_refunds_notifier.dart';

final franchiseRefundsRepositoryProvider =
    Provider<IFranchiseRefundsRepository>((ref) {
      return FranchiseRefundsRepository(ref.watch(dashboardServiceProvider));
    });

final franchiseRefundsNotifierProvider =
    NotifierProvider<
      FranchiseRefundsNotifier,
      AsyncValue<FranchiseRefundsDashboardViewModel>
    >(FranchiseRefundsNotifier.new);
