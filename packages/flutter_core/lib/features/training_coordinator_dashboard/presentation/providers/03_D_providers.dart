// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_training_coordinator_repository.dart';
import '../view_models/04_V_training_coordinator_notifier.dart';

final Provider<ITrainingCoordinatorRepository>
trainingCoordinatorRepositoryProvider =
    Provider<ITrainingCoordinatorRepository>((Ref ref) {
      return TrainingCoordinatorRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<
  TrainingCoordinatorNotifier,
  AsyncValue<TrainingCoordinatorDashboardViewModel>
>
trainingCoordinatorDashboardProvider =
    NotifierProvider<
      TrainingCoordinatorNotifier,
      AsyncValue<TrainingCoordinatorDashboardViewModel>
    >(TrainingCoordinatorNotifier.new);
