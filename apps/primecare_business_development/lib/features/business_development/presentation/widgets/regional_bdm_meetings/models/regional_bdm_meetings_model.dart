import 'package:primecare_models/primecare_models.dart';

class RegionalBdmMeetingsModel extends BaseScreenState<RegionalBdmMeetingsModel> {
  const RegionalBdmMeetingsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmMeetingsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmMeetingsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
