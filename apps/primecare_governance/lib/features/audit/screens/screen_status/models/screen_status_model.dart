import 'package:primecare_models/primecare_models.dart';

class ScreenStatusModel extends BaseScreenState<ScreenStatusModel> {
  const ScreenStatusModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ScreenStatusModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ScreenStatusModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
