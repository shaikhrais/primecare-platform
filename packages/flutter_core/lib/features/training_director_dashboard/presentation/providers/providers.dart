import '../../../../flutter_core.dart';
import '../../domain/repositories/training_director_repository.dart';
import '../view_models/training_director_notifier.dart';

final Provider<ITrainingDirectorRepository> trainingDirectorRepositoryProvider =
    Provider<ITrainingDirectorRepository>((Ref ref) {
      return TrainingDirectorRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<
  TrainingDirectorNotifier,
  AsyncValue<TrainingDirectorDashboardViewModel>
>
trainingDirectorDashboardProvider =
    NotifierProvider<
      TrainingDirectorNotifier,
      AsyncValue<TrainingDirectorDashboardViewModel>
    >(TrainingDirectorNotifier.new);
