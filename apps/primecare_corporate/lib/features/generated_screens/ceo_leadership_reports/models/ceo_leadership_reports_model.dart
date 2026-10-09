import 'package:primecare_models/primecare_models.dart';

class CeoLeadershipReportsModel extends BaseScreenState<CeoLeadershipReportsModel> {
  const CeoLeadershipReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CeoLeadershipReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CeoLeadershipReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
