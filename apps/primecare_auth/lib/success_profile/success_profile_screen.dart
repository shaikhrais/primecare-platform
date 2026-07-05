import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/success_profile_header_section.dart';
import 'sections/success_profile_identity_summary_section.dart';
import 'sections/success_profile_details_form_section.dart';
import 'sections/success_profile_preferences_or_documents_section.dart';
import 'sections/success_profile_action_bar_section.dart';

class SuccessProfileScreen extends GovernedScreen {
  @override
  String get screenDescription =>
      'The App Hub acts as the centralized gateway for all PrimeCare portals. Displays all available applications, enforces role-based access control, and allows direct secure single-sign-on launch.';

  @override
  List<String> get requiredComponents => const [
        'UserAuthStatusIndicator',
        'SessionVerificationStatus',
        'UserDetailsDisplay',
        'SessionTokenDisplay',
        'SignOutButton',
        'Notifications',
        'AppGrid',
      ];

  @override
  List<String> get requiredFunctions => const [
        'verifySessionStatus',
        'fetchUserDetails',
        'fetchSessionToken',
        'signOutUser',
        'handleForcedLogout',
        'launchPortalApp',
      ];

  const SuccessProfileScreen({super.key});

  @override
  String get featureId => 'auth.success';

  @override
  String get requiredRole => 'Public';

  @override
  List<String> get translationKeys => [
        'auth_success_identity_portal',
        'auth_success_session_verified',
        'auth_success_active_session',
        'auth_success_logged_in_as',
        'auth_success_assigned_role',
        'auth_success_session_token',
        'auth_success_sign_out',
        'auth_success_parity_title',
        'auth_success_parity_subtitle',
        'auth_success_default_user',
      ];

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Slate 900
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SuccessProfileHeaderSection(),
                    SuccessProfileIdentitySummarySection(),
                  ],
                ),
                const SizedBox(height: 40),
                const SuccessProfileDetailsFormSection(),
                const SizedBox(height: 32),
                const SuccessProfileActionBarSection(),
                const SizedBox(height: 48),
                const SuccessProfilePreferencesOrDocumentsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
