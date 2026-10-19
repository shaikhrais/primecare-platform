import 'package:primecare_models/primecare_models.dart';

class RpnReportsModel extends BaseScreenState<RpnReportsModel> {
  const RpnReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RpnReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RpnReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
