import 'package:primecare_models/primecare_models.dart';

class VitalsTrackingModel extends BaseScreenState<VitalsTrackingModel> {
  const VitalsTrackingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VitalsTrackingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VitalsTrackingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
