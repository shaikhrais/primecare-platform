import 'package:primecare_models/primecare_models.dart';

class RegulatoryChangeRadarModel extends BaseScreenState<RegulatoryChangeRadarModel> {
  const RegulatoryChangeRadarModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegulatoryChangeRadarModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegulatoryChangeRadarModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
