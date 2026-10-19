import 'package:primecare_models/primecare_models.dart';

class SuccessProfileModel extends BaseScreenState<SuccessProfileModel> {
  const SuccessProfileModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SuccessProfileModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SuccessProfileModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
