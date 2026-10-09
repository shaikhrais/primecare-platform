import 'package:primecare_models/primecare_models.dart';

class DataPrivacyMonitorModel extends BaseScreenState<DataPrivacyMonitorModel> {
  const DataPrivacyMonitorModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DataPrivacyMonitorModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DataPrivacyMonitorModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
