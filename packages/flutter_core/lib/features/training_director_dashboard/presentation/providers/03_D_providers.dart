// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_training_director_repository.dart';
import '../view_models/04_V_training_director_notifier.dart';

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
