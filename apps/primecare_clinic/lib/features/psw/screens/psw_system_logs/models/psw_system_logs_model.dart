import 'package:primecare_models/primecare_models.dart';

class PswSystemLogsModel extends BaseScreenState<PswSystemLogsModel> {
  const PswSystemLogsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswSystemLogsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswSystemLogsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
