import 'package:primecare_models/primecare_models.dart';

class ClientIssueModel extends BaseScreenState<ClientIssueModel> {
  const ClientIssueModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClientIssueModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClientIssueModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
