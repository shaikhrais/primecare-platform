import 'package:primecare_models/primecare_models.dart';

class PswShiftTrackerModel extends BaseScreenState<PswShiftTrackerModel> {
  const PswShiftTrackerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswShiftTrackerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswShiftTrackerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
