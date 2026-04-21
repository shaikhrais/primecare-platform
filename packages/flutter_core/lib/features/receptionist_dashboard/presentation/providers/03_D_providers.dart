// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_receptionist_repository.dart';
import '../view_models/04_V_receptionist_notifier.dart';

final Provider<IReceptionistRepository> receptionistRepositoryProvider =
    Provider<IReceptionistRepository>((Ref ref) {
      return ReceptionistRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<
  ReceptionistNotifier,
  AsyncValue<ReceptionistDashboardViewModel>
>
receptionistDashboardProvider =
    NotifierProvider<
      ReceptionistNotifier,
      AsyncValue<ReceptionistDashboardViewModel>
    >(ReceptionistNotifier.new);
