import 'package:primecare_models/primecare_models.dart';

class ResetPasswordModel extends BaseScreenState<ResetPasswordModel> {
  const ResetPasswordModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ResetPasswordModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ResetPasswordModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
