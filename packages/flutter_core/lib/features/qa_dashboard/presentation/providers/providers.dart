import '../../../../flutter_core.dart';
import '../../domain/repositories/qa_repository.dart';
import '../view_models/qa_notifier.dart';

final Provider<IQaRepository> qaRepositoryProvider = Provider<IQaRepository>((
  Ref ref,
) {
  return QaRepository(ref.watch(domainServiceProvider));
});

final NotifierProvider<QaNotifier, AsyncValue<QaDashboardViewModel>>
qaDashboardProvider =
    NotifierProvider<QaNotifier, AsyncValue<QaDashboardViewModel>>(
      QaNotifier.new,
    );
