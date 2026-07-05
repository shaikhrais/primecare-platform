import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:web/web.dart' as web;
import 'sections/consent_header_section.dart';
import 'sections/consent_consent_content_section.dart';
import 'sections/consent_consent_inputs_section.dart';
import 'sections/consent_action_bar_section.dart';

class ConsentScreen extends GovernedScreen {
  @override
  String get screenDescription =>
      'The consent screen requires user authentication, language selection, consent review, and session management functionalities.';

  @override
  List<String> get requiredComponents => const [
        'LanguageSelector',
        'ConsentInformationDisplay',
        'SessionTokenDisplay',
        'NotificationBanner',
      ];

  @override
  List<String> get requiredFunctions => const [
        'handleLogin',
        'selectLanguage',
        'reviewConsent',
        'navigateToSuccess',
        'handleSignOut',
      ];

  final String redirectUri;

  const ConsentScreen({super.key, required this.redirectUri});

  @override
  String get featureId => 'auth.consent';

  @override
  String get requiredRole => 'Public';

  @override
  List<String> get translationKeys => [
        'auth_consent_authorize_title',
        'auth_consent_security_required',
        'auth_consent_permission_request',
        'auth_consent_explanation',
        'auth_consent_authorizing_account',
        'auth_success_default_user',
        'auth_consent_redirecting',
        'auth_consent_approve',
        'auth_consent_cancel',
      ];

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    return _ConsentScreenBody(redirectUri: redirectUri);
  }
}

class _ConsentScreenBody extends ConsumerStatefulWidget {
  final String redirectUri;

  const _ConsentScreenBody({required this.redirectUri});

  @override
  ConsumerState<_ConsentScreenBody> createState() => _ConsentScreenBodyState();
}

class _ConsentScreenBodyState extends ConsumerState<_ConsentScreenBody> {
  @override
  void initState() {
    super.initState();
    _startAutoRedirect();
  }

  void _startAutoRedirect() {
    Future.microtask(() async {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      
      final authState = ref.read(authProvider);
      final redirectUri = widget.redirectUri;
      final delimiter = redirectUri.contains('?') ? '&' : '?';
      final urlWithToken = '$redirectUri${delimiter}token=${authState.token ?? ''}&role=${Uri.encodeComponent(authState.role ?? '')}&userId=${authState.userId ?? ''}';
      
      web.window.location.href = urlWithToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ConsentHeaderSection(),
              ConsentConsentContentSection(),
              ConsentConsentInputsSection(),
              ConsentActionBarSection(),
            ],
          ),
        ),
      ),
    );
  }
}
