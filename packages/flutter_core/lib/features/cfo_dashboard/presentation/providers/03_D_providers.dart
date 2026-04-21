import '../../domain/repositories/03_D_cfo_repository.dart';
import '../../../../00_B_flutter_core.dart';

final cfoRepositoryProvider = Provider<ICfoRepository>((ref) {
  return CfoRepository(ref.watch(domainServiceProvider));
});

final cfoDashboardProvider = Provider<AsyncValue<Map<String, dynamic>>>((ref) {
  return AsyncValue.data({'cash': '\$3.4M', 'margin': '18.4%'});
});
