import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_coo_repository.dart';

final cooRepositoryProvider = Provider<ICooRepository>((ref) {
  return CooRepository(ref.watch(domainServiceProvider));
});

final cooDashboardProvider = Provider<AsyncValue<Map<String, dynamic>>>((ref) {
  return AsyncValue.data({'active_incidents': 2, 'compliance': '100%'});
});
