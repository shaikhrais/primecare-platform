import 'package:primecare_models/primecare_models.dart';

class ResponseBotAuditModel extends BaseScreenState<ResponseBotAuditModel> {
  const ResponseBotAuditModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ResponseBotAuditModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ResponseBotAuditModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
