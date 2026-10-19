import 'package:primecare_models/primecare_models.dart';

class LeadershipReportsModel extends BaseScreenState<LeadershipReportsModel> {
  const LeadershipReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LeadershipReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LeadershipReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
