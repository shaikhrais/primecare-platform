import 'package:primecare_models/primecare_models.dart';

class RegionalBdmCompetitorNotesModel extends BaseScreenState<RegionalBdmCompetitorNotesModel> {
  const RegionalBdmCompetitorNotesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmCompetitorNotesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmCompetitorNotesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
