import '../../../../flutter_core.dart';
import '../../domain/repositories/coo_repository.dart';
import '../view_models/coo_notifier.dart';

final Provider<ICooRepository> cooRepositoryProvider = Provider<ICooRepository>(
  (Ref ref) {
    return CooRepository(ref.watch(domainServiceProvider));
  },
);

final NotifierProvider<CooNotifier, AsyncValue<CooDashboardViewModel>>
cooDashboardProvider =
    NotifierProvider<CooNotifier, AsyncValue<CooDashboardViewModel>>(
      CooNotifier.new,
    );
