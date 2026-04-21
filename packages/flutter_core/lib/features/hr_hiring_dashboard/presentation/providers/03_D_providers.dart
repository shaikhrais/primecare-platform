// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_hr_hiring_repository.dart';
import '../view_models/04_V_hr_hiring_notifier.dart';

final Provider<IHrHiringRepository> hrHiringRepositoryProvider =
    Provider<IHrHiringRepository>((Ref ref) {
      return HrHiringRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<HrHiringNotifier, AsyncValue<HrHiringDashboardViewModel>>
hrHiringDashboardProvider =
    NotifierProvider<HrHiringNotifier, AsyncValue<HrHiringDashboardViewModel>>(
      HrHiringNotifier.new,
    );
