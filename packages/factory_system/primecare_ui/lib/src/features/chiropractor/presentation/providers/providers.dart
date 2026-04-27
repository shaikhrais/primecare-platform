import 'package:primecare_ui/primecare_ui.dart';
// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_core/flutter_core.dart';
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
