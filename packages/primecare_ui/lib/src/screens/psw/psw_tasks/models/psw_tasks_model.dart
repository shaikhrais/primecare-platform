import 'package:primecare_models/primecare_models.dart';

class PswTasksModel extends BaseScreenState<PswTasksModel> {
  const PswTasksModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswTasksModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswTasksModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
