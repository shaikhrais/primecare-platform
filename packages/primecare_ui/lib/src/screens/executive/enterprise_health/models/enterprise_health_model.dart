import 'package:primecare_models/primecare_models.dart';

class EnterpriseHealthModel extends BaseScreenState<EnterpriseHealthModel> {
  const EnterpriseHealthModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EnterpriseHealthModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EnterpriseHealthModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
