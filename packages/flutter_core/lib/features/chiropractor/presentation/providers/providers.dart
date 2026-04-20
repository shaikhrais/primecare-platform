import '../../../../flutter_core.dart';
import '../../domain/repositories/chiropractor_repository.dart';
import '../view_models/chiropractor_notifier.dart';
import '../../domain/models/chiropractor_state.dart';

final chiropractorRepositoryProvider = Provider<IChiropractorRepository>((ref) {
  final domainService = ref.watch(domainServiceProvider);
  return ChiropractorRepository(domainService);
});

final chiropractorNotifierProvider =
    NotifierProvider<ChiropractorNotifier, ChiropractorState>(() {
      return ChiropractorNotifier();
    });
