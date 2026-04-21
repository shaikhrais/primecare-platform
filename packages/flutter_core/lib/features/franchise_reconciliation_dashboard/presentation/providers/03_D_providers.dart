// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_franchise_reconciliation_repository.dart';
import '../view_models/04_V_franchise_reconciliation_notifier.dart';

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
