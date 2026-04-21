// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_client_repository.dart';
import '../view_models/04_V_client_notifier.dart';

final clientRepositoryProvider = Provider<IClientRepository>((ref) {
  return ClientRepository(ref.watch(dashboardServiceProvider));
});

final clientNotifierProvider =
    NotifierProvider<ClientNotifier, AsyncValue<ClientDashboardViewModel>>(
      ClientNotifier.new,
    );
