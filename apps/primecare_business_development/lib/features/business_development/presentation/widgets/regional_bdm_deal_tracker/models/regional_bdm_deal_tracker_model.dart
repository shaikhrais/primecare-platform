import 'package:primecare_models/primecare_models.dart';

class RegionalBdmDealTrackerModel extends BaseScreenState<RegionalBdmDealTrackerModel> {
  const RegionalBdmDealTrackerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmDealTrackerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmDealTrackerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
