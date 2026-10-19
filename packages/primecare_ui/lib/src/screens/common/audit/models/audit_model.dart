import 'package:primecare_models/primecare_models.dart';

class AuditModel extends BaseScreenState<AuditModel> {
  const AuditModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AuditModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AuditModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
