import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain_service.dart';
import '../../domain/repositories/psw_repository.dart';
import '../../domain/models/psw_state.dart';
import '../view_models/psw_notifier.dart';

final Provider<IPswRepository> pswRepositoryProvider = Provider<IPswRepository>(
  (Ref ref) {
    final domainService = ref.watch(domainServiceProvider);
    return PswRepository(domainService);
  },
);

final NotifierProvider<PswNotifier, PswState> pswDashboardProvider =
    NotifierProvider<PswNotifier, PswState>(() {
      return PswNotifier();
    });
