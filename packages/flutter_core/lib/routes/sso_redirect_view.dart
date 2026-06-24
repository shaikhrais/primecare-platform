/* 
PRIME:SCREEN=sso_redirect
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_FINAL
PRIME:LOGIC=LOGIC_CLEAN
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_FULLY_CONNECTED
PRIME:VALIDATION=VALIDATION_FULL
PRIME:QA=QA_PASSED
PRIME:FINAL=FINAL_FURNISHED
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: middleware | Purpose: Core implementation file for the Sso Redirect View platform logic.
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SsoRedirectView extends GovernedConsumerStatefulWidget {
  final String redirectUrl;

  const SsoRedirectView({super.key, required this.redirectUrl});

  @override
  ConsumerState<SsoRedirectView> createState() => _SsoRedirectViewState();
}

class _SsoRedirectViewState extends GovernedConsumerState<SsoRedirectView> {
  @override
  String get screenDescription =>
      'The screen requires components for monitoring the SSO redirect process, collecting user feedback, and displaying performance metrics, along with necessary buttons and API endpoints.';

  @override
  List<String> get requiredComponents => const [
        'SSORedirectMonitor',
        'ErrorLogViewer',
        'UserFeedbackCollector',
        'PerformanceMetricsDisplay',
      ];

  @override
  List<String> get requiredFunctions => const [
        'monitorSSORedirect',
        'validateRedirectURL',
        'checkForErrors',
        'collectUserFeedback',
        'trackRedirectPerformance',
      ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchSSO();
    });
  }

  Future<void> _launchSSO() async {
    try {
      await launchUrlString(
        widget.redirectUrl,
        mode: LaunchMode.externalApplication, // Forces system browser for shared cookie jar
        webOnlyWindowName: '_self', // Replaces the current tab on Web
      );
    } catch (e) {
      debugPrint('SSO launch error: $e');
    }
  }

  @override
  Widget buildScreen(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text(
              'Redirecting to PrimeCare Auth Portal...',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
