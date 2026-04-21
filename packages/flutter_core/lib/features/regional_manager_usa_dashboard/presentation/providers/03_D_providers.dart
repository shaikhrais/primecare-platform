// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_regional_manager_usa_repository.dart';
import '../view_models/04_V_regional_manager_usa_notifier.dart';

final Provider<IRegionalManagerUsaRepository>
regionalManagerUsaRepositoryProvider = Provider<IRegionalManagerUsaRepository>((
  Ref ref,
) {
  return RegionalManagerUsaRepository(ref.watch(domainServiceProvider));
});

final NotifierProvider<
  RegionalManagerUsaNotifier,
  AsyncValue<RegionalManagerUsaDashboardViewModel>
>
regionalManagerUsaDashboardProvider =
    NotifierProvider<
      RegionalManagerUsaNotifier,
      AsyncValue<RegionalManagerUsaDashboardViewModel>
    >(RegionalManagerUsaNotifier.new);
