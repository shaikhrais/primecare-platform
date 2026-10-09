import 'package:primecare_models/primecare_models.dart';

class SsoRedirectModel extends BaseScreenState<SsoRedirectModel> {
  const SsoRedirectModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SsoRedirectModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SsoRedirectModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
