import 'package:primecare_models/primecare_models.dart';

class CorrectiveActionsModel extends BaseScreenState<CorrectiveActionsModel> {
  const CorrectiveActionsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CorrectiveActionsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CorrectiveActionsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
