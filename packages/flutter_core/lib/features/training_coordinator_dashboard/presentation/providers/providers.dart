import '../../../../flutter_core.dart';
import '../../domain/repositories/training_coordinator_repository.dart';
import '../view_models/training_coordinator_notifier.dart';

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
