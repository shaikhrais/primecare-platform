// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_intake_repository.dart';
import '../view_models/04_V_intake_notifier.dart';

final Provider<IIntakeRepository> intakeRepositoryProvider =
    Provider<IIntakeRepository>((Ref ref) {
      return IntakeRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<IntakeNotifier, AsyncValue<IntakeDashboardViewModel>>
intakeDashboardProvider =
    NotifierProvider<IntakeNotifier, AsyncValue<IntakeDashboardViewModel>>(
      IntakeNotifier.new,
    );
