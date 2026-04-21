// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_qa_repository.dart';

final qaRepositoryProvider = Provider<IQaRepository>((ref) {
  return QaRepository(ref.watch(domainServiceProvider));
});

final qaDashboardProvider = Provider<AsyncValue<Map<String, dynamic>>>((ref) => const AsyncValue.data({'audit': '99.2%', 'rectification': '100%'}));
