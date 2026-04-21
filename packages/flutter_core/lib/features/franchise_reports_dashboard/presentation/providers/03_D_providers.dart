// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_franchise_reports_repository.dart';
import '../view_models/04_V_franchise_reports_notifier.dart';

final franchiseReportsRepositoryProvider =
    Provider<IFranchiseReportsRepository>((ref) {
      return FranchiseReportsRepository(ref.watch(dashboardServiceProvider));
    });

final franchiseReportsNotifierProvider =
    NotifierProvider<
      FranchiseReportsNotifier,
      AsyncValue<FranchiseReportsDashboardViewModel>
    >(FranchiseReportsNotifier.new);
