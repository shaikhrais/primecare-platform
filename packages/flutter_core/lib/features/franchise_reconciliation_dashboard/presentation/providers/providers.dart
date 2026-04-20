import '../../../../flutter_core.dart';
import '../../domain/repositories/franchise_reconciliation_repository.dart';
import '../view_models/franchise_reconciliation_notifier.dart';

final franchiseReconciliationRepositoryProvider =
    Provider<IFranchiseReconciliationRepository>((Ref ref) {
      return FranchiseReconciliationRepository(
        ref.watch(domainServiceProvider),
      );
    });

final franchiseReconciliationDashboardProvider =
    NotifierProvider<
      FranchiseReconciliationNotifier,
      AsyncValue<FranchiseReconciliationDashboardViewModel>
    >(FranchiseReconciliationNotifier.new);
