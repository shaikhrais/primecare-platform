import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/training_director_dashboard_view_model.dart';
import '../mappers/training_director_dashboard_mapper.dart';

final trainingDirectorDashboardAdapterProvider = FutureProvider<TrainingDirectorDashboardViewModel>((ref) async {
  return TrainingDirectorDashboardMapper.fromMock({});
});
