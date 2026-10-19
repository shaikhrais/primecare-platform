import 'package:primecare_models/primecare_models.dart';

class ForgotPasswordModel extends BaseScreenState<ForgotPasswordModel> {
  const ForgotPasswordModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ForgotPasswordModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ForgotPasswordModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
