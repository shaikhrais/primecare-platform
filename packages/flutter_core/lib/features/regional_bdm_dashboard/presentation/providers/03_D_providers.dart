// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_regional_bdm_repository.dart';
import '../view_models/04_V_regional_bdm_notifier.dart';

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
