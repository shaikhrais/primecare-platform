import '../../../../flutter_core.dart';
import '../../domain/repositories/cto_repository.dart';
import '../view_models/cto_notifier.dart';

final Provider<ICtoRepository> ctoRepositoryProvider = Provider<ICtoRepository>(
  (Ref ref) {
    return CtoRepository(ref.watch(domainServiceProvider));
  },
);

final NotifierProvider<CtoNotifier, AsyncValue<CtoDashboardViewModel>>
ctoDashboardProvider =
    NotifierProvider<CtoNotifier, AsyncValue<CtoDashboardViewModel>>(
      CtoNotifier.new,
    );
