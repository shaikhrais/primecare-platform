import 'package:primecare_models/primecare_models.dart';

class ScreenAuditModel extends BaseScreenState<ScreenAuditModel> {
  const ScreenAuditModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ScreenAuditModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ScreenAuditModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
