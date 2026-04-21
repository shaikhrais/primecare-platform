// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_compliance_manager_repository.dart';
import '../view_models/04_V_compliance_manager_notifier.dart';

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
