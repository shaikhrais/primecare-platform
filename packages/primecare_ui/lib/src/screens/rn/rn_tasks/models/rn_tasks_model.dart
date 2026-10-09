import 'package:primecare_models/primecare_models.dart';

class RnTasksModel extends BaseScreenState<RnTasksModel> {
  const RnTasksModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RnTasksModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RnTasksModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
