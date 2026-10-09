import 'package:primecare_models/primecare_models.dart';

class DefaultNotImplementedModel extends BaseScreenState<DefaultNotImplementedModel> {
  const DefaultNotImplementedModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DefaultNotImplementedModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DefaultNotImplementedModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
