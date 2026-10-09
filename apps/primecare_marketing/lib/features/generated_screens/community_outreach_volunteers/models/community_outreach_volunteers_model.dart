import 'package:primecare_models/primecare_models.dart';

class CommunityOutreachVolunteersModel extends BaseScreenState<CommunityOutreachVolunteersModel> {
  const CommunityOutreachVolunteersModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunityOutreachVolunteersModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunityOutreachVolunteersModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
