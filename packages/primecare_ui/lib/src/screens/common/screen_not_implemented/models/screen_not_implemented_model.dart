import 'package:primecare_models/primecare_models.dart';

class ScreenNotImplementedModel extends BaseScreenState<ScreenNotImplementedModel> {
  const ScreenNotImplementedModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ScreenNotImplementedModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ScreenNotImplementedModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
