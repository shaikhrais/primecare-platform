import '../../../../flutter_core.dart';
import '../../domain/repositories/regional_manager_usa_repository.dart';
import '../view_models/regional_manager_usa_notifier.dart';

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
