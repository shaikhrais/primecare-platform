import '../../../../flutter_core.dart';
import '../../domain/repositories/client_repository.dart';
import '../view_models/client_notifier.dart';

final clientRepositoryProvider = Provider<IClientRepository>((ref) {
  return ClientRepository(ref.watch(dashboardServiceProvider));
});

final clientNotifierProvider =
    NotifierProvider<ClientNotifier, AsyncValue<ClientDashboardViewModel>>(
      ClientNotifier.new,
    );
