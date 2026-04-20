import '../../../../flutter_core.dart';
import '../../domain/repositories/ceo_repository.dart';
import '../view_models/ceo_notifier.dart';

final Provider<ICeoRepository> ceoRepositoryProvider = Provider<ICeoRepository>(
  (Ref ref) {
    return CeoRepository(ref.watch(domainServiceProvider));
  },
);

final NotifierProvider<CeoNotifier, AsyncValue<CeoDashboardViewModel>>
ceoDashboardProvider =
    NotifierProvider<CeoNotifier, AsyncValue<CeoDashboardViewModel>>(
      CeoNotifier.new,
    );
