import 'package:primecare_models/primecare_models.dart';

class ShiftTasksModel extends BaseScreenState<ShiftTasksModel> {
  const ShiftTasksModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ShiftTasksModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ShiftTasksModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
