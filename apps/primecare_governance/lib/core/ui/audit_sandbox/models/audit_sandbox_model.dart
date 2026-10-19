import 'package:primecare_models/primecare_models.dart';

class AuditSandboxModel extends BaseScreenState<AuditSandboxModel> {
  const AuditSandboxModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AuditSandboxModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AuditSandboxModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
