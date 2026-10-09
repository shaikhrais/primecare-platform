import 'package:primecare_models/primecare_models.dart';

class GovernedModel extends BaseScreenState<GovernedModel> {
  const GovernedModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GovernedModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GovernedModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
