// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_regional_manager_ontario_repository.dart';
import '../view_models/04_V_regional_manager_ontario_notifier.dart';

final Provider<IRegionalManagerOntarioRepository>
regionalManagerOntarioRepositoryProvider =
    Provider<IRegionalManagerOntarioRepository>((Ref ref) {
      return RegionalManagerOntarioRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<
  RegionalManagerOntarioNotifier,
  AsyncValue<RegionalManagerOntarioDashboardViewModel>
>
regionalManagerOntarioDashboardProvider =
    NotifierProvider<
      RegionalManagerOntarioNotifier,
      AsyncValue<RegionalManagerOntarioDashboardViewModel>
    >(RegionalManagerOntarioNotifier.new);
