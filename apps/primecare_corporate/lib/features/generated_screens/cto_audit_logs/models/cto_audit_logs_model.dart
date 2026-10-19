import 'package:primecare_models/primecare_models.dart';

class CtoAuditLogsModel extends BaseScreenState<CtoAuditLogsModel> {
  const CtoAuditLogsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoAuditLogsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoAuditLogsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
