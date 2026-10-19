import 'package:primecare_models/primecare_models.dart';

class HrHiringCredentialsModel extends BaseScreenState<HrHiringCredentialsModel> {
  const HrHiringCredentialsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrHiringCredentialsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrHiringCredentialsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
