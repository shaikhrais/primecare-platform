import 'package:primecare_models/primecare_models.dart';

class PoliciesModel extends BaseScreenState<PoliciesModel> {
  const PoliciesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PoliciesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PoliciesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
