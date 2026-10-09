import 'package:primecare_models/primecare_models.dart';

class PendingTaskQueueModel extends BaseScreenState<PendingTaskQueueModel> {
  const PendingTaskQueueModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PendingTaskQueueModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PendingTaskQueueModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
