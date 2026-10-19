import 'package:primecare_models/primecare_models.dart';

class EnterpriseCommandCenter4KModel extends BaseScreenState<EnterpriseCommandCenter4KModel> {
  const EnterpriseCommandCenter4KModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EnterpriseCommandCenter4KModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EnterpriseCommandCenter4KModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
