import 'package:primecare_models/primecare_models.dart';

class SchedulingOperations4KModel extends BaseScreenState<SchedulingOperations4KModel> {
  const SchedulingOperations4KModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SchedulingOperations4KModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SchedulingOperations4KModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
