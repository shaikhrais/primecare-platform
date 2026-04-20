import '../../../../flutter_core.dart';
import '../../domain/repositories/compliance_manager_repository.dart';
import '../view_models/compliance_manager_notifier.dart';

final Provider<IComplianceManagerRepository>
complianceManagerRepositoryProvider = Provider<IComplianceManagerRepository>((
  Ref ref,
) {
  return ComplianceManagerRepository(ref.watch(domainServiceProvider));
});

final NotifierProvider<
  ComplianceManagerNotifier,
  AsyncValue<ComplianceManagerDashboardViewModel>
>
complianceManagerDashboardProvider =
    NotifierProvider<
      ComplianceManagerNotifier,
      AsyncValue<ComplianceManagerDashboardViewModel>
    >(() {
      return ComplianceManagerNotifier();
    });
