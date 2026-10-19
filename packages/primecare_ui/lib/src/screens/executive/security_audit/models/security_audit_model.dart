import 'package:primecare_models/primecare_models.dart';

class SecurityAuditModel extends BaseScreenState<SecurityAuditModel> {
  const SecurityAuditModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SecurityAuditModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SecurityAuditModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
