import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialMediaScreenState extends DashboardState<SocialMediaScreenState> {
  SocialMediaScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SocialMediaScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SocialMediaScreenState(isLoading: isLoading, error: error, data: data);
}

class SocialMediaScreenController
    extends BaseDashboardController<SocialMediaScreenState> {
  SocialMediaScreenController(Ref ref)
    : super(
        ref,
        initialState: SocialMediaScreenState(isLoading: true, data: {}),
        endpoint: '/management/social-media',
      );
}

final social_mediaControllerProvider =
    StateNotifierProvider<SocialMediaScreenController, SocialMediaScreenState>((
      ref,
    ) {
      return SocialMediaScreenController(ref);
    });
