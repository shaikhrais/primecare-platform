import '../../../../flutter_core.dart';
import '../../domain/repositories/regional_bdm_repository.dart';
import '../view_models/regional_bdm_notifier.dart';

final Provider<IRegionalBdmRepository> regionalBdmRepositoryProvider =
    Provider<IRegionalBdmRepository>((Ref ref) {
      return RegionalBdmRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<
  RegionalBdmNotifier,
  AsyncValue<RegionalBdmDashboardViewModel>
>
regionalBdmDashboardProvider =
    NotifierProvider<
      RegionalBdmNotifier,
      AsyncValue<RegionalBdmDashboardViewModel>
    >(RegionalBdmNotifier.new);
