import '../../../../flutter_core.dart';
import '../../domain/repositories/regional_manager_ontario_repository.dart';
import '../view_models/regional_manager_ontario_notifier.dart';

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
