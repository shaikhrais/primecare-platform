import 'package:primecare_models/primecare_models.dart';

class ReceptionistAnalyticsModel extends BaseScreenState<ReceptionistAnalyticsModel> {
  const ReceptionistAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ReceptionistAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ReceptionistAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
