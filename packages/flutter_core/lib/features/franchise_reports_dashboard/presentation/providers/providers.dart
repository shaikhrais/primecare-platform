import '../../../../flutter_core.dart';
import '../../domain/repositories/franchise_reports_repository.dart';
import '../view_models/franchise_reports_notifier.dart';

final franchiseReportsRepositoryProvider =
    Provider<IFranchiseReportsRepository>((ref) {
      return FranchiseReportsRepository(ref.watch(dashboardServiceProvider));
    });

final franchiseReportsNotifierProvider =
    NotifierProvider<
      FranchiseReportsNotifier,
      AsyncValue<FranchiseReportsDashboardViewModel>
    >(FranchiseReportsNotifier.new);
