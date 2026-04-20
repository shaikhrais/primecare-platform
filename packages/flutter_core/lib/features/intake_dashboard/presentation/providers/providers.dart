import '../../../../flutter_core.dart';
import '../../domain/repositories/intake_repository.dart';
import '../view_models/intake_notifier.dart';

final Provider<IIntakeRepository> intakeRepositoryProvider =
    Provider<IIntakeRepository>((Ref ref) {
      return IntakeRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<IntakeNotifier, AsyncValue<IntakeDashboardViewModel>>
intakeDashboardProvider =
    NotifierProvider<IntakeNotifier, AsyncValue<IntakeDashboardViewModel>>(
      IntakeNotifier.new,
    );
