import 'package:primecare_models/primecare_models.dart';

class CommunityOutreachPartnershipsModel extends BaseScreenState<CommunityOutreachPartnershipsModel> {
  const CommunityOutreachPartnershipsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CommunityOutreachPartnershipsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CommunityOutreachPartnershipsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
