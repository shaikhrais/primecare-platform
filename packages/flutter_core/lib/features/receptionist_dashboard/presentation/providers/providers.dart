import '../../../../flutter_core.dart';
import '../../domain/repositories/receptionist_repository.dart';
import '../../domain/models/receptionist_dashboard_view_model.dart';
import '../view_models/receptionist_notifier.dart';

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
