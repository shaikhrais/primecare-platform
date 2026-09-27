/* 
PRIME:SCREEN=clinic_login
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:go_router/go_router.dart';

String? validateClinicReturnUrl(String? rawValue) {
  if (rawValue == null || rawValue.trim().isEmpty) {
    return '/dashboard';
  }

  final decoded = Uri.decodeComponent(rawValue);
  final uri = Uri.tryParse(decoded);

  if (uri == null) {
    return null;
  }

  if (uri.hasScheme || uri.hasAuthority) {
    return null;
  }

  const blockedRoutes = <String>{
    '/login',
    '/logout',
    '/sso-redirect',
    '/auth/callback',
    '/auth/error',
    '/success',
  };

  if (blockedRoutes.contains(uri.path)) {
    return null;
  }

  if (!uri.path.startsWith('/')) {
    return null;
  }

  return uri.toString();
}

class ClinicLoginBridge extends GovernedConsumerStatefulWidget {
  final String? returnUrl;

  const ClinicLoginBridge({super.key, this.returnUrl});

  @override
  ConsumerState<ClinicLoginBridge> createState() => _ClinicLoginBridgeState();
}

class _ClinicLoginBridgeState extends GovernedConsumerState<ClinicLoginBridge> {
  @override
  String get screenDescription =>
      'Zero-Trust clinic login bridge that validates the return location and redirects unauthenticated users once to the central SSO portal.';

  @override
  List<String> get requiredComponents => const ['ClinicLoginBridgeComponent'];

  @override
  List<String> get requiredFunctions => const ['startLogin', 'validateClinicReturnUrl'];

  bool _redirectStarted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndRedirect();
    });
  }

  void _checkAndRedirect() {
    final authState = ref.read(authProvider);
    if (!authState.isInitialized) {
      return;
    }

    final safeReturnUrl = validateClinicReturnUrl(widget.returnUrl) ?? '/dashboard';

    if (authState.isAuthenticated) {
      context.go(safeReturnUrl);
      return;
    }

    if (_redirectStarted) {
      return;
    }

    setState(() {
      _redirectStarted = true;
    });

    final stateToken = DateTime.now().millisecondsSinceEpoch.toString();

    final ssoPortal = RouteGuard.ssoPortalUrl ?? 'https://primecare-auth.pages.dev';
    
    final currentOrigin = Uri.base.origin;
    final callbackUrl = currentOrigin.contains("localhost") || currentOrigin.contains("pages.dev")
        ? "$currentOrigin/auth/callback"
        : "https://primecare-clinic.pages.dev/auth/callback";

    final authUri = Uri.parse('$ssoPortal/login').replace(
      queryParameters: {
        'clientId': 'primecare-clinic',
        'callbackUrl': callbackUrl,
        'returnUrl': safeReturnUrl,
        'state': stateToken,
      },
    );

    launchUrlString(
      authUri.toString(),
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: '_self',
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(
              'Initializing connection to PrimeCare Identity...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
