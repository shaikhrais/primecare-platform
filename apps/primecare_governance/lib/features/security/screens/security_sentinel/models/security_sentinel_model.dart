import 'package:primecare_models/primecare_models.dart';

class SecuritySentinelModel extends BaseScreenState<SecuritySentinelModel> {
  const SecuritySentinelModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SecuritySentinelModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SecuritySentinelModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
