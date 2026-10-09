import 'package:primecare_models/primecare_models.dart';

class RmtReportsModel extends BaseScreenState<RmtReportsModel> {
  const RmtReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RmtReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RmtReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
