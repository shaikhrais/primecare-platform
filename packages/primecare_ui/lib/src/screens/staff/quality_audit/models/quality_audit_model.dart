import 'package:primecare_models/primecare_models.dart';

class QualityAuditModel extends BaseScreenState<QualityAuditModel> {
  const QualityAuditModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAuditModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAuditModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
