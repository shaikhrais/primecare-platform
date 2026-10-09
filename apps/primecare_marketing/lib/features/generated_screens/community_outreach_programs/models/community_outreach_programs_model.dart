import 'package:primecare_models/primecare_models.dart';

class CommunityOutreachProgramsModel extends BaseScreenState<CommunityOutreachProgramsModel> {
  const CommunityOutreachProgramsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunityOutreachProgramsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunityOutreachProgramsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
