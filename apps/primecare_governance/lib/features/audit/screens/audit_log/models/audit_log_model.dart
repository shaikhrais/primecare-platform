import 'package:primecare_models/primecare_models.dart';

class AuditLogModel extends BaseScreenState<AuditLogModel> {
  const AuditLogModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AuditLogModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AuditLogModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
