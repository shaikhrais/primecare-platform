// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_qa_repository.dart';
import '../view_models/04_V_qa_notifier.dart';

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
