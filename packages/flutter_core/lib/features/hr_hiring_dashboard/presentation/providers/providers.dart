import '../../../../flutter_core.dart';
import '../../domain/repositories/hr_hiring_repository.dart';
import '../view_models/hr_hiring_notifier.dart';

final Provider<IHrHiringRepository> hrHiringRepositoryProvider =
    Provider<IHrHiringRepository>((Ref ref) {
      return HrHiringRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<HrHiringNotifier, AsyncValue<HRHiringDashboardViewModel>>
hrHiringDashboardProvider =
    NotifierProvider<HrHiringNotifier, AsyncValue<HRHiringDashboardViewModel>>(
      HrHiringNotifier.new,
    );
