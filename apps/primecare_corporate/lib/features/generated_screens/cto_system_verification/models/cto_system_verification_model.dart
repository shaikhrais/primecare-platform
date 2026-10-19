import 'package:primecare_models/primecare_models.dart';

class CtoSystemVerificationModel extends BaseScreenState<CtoSystemVerificationModel> {
  const CtoSystemVerificationModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoSystemVerificationModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoSystemVerificationModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
