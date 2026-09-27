// Governance - Category: middleware | Purpose: Handle SSO authorization callback logic on Web.
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../auth_service.dart';
import 'groups/common_routes.dart';

class AuthCallbackView extends GovernedConsumerStatefulWidget {
  final Map<String, String> queryParameters;

  const AuthCallbackView({super.key, required this.queryParameters});

  @override
  ConsumerState<AuthCallbackView> createState() => _AuthCallbackViewState();
}

class _AuthCallbackViewState extends GovernedConsumerState<AuthCallbackView> {
  @override
  String get screenDescription =>
      'The screen requires handling SSO authorization callbacks, displaying authentication status, and managing user redirection based on roles.';

  @override
  List<String> get requiredComponents => const [
        'AuthStatusDisplay',
        'AuthErrorDisplay',
        'AuthLogsDisplay',
        'AuthMetricsDisplay',
        'UserRoleDisplay',
      ];

  @override
  List<String> get requiredFunctions => const [
        'handleSSOCallback',
        'redirectToDashboard',
        'handleMissingParameters',
        'logAuthenticationAttempt',
      ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _processAuth();
    });
  }

  Future<void> _processAuth() async {
    final token = widget.queryParameters['token'];
    final role = widget.queryParameters['role'];
    final userId = widget.queryParameters['userId'] ?? 'unknown';
    final rawReturnUrl = widget.queryParameters['returnUrl'];
    
    final safeReturnUrl = validateClinicReturnUrl(rawReturnUrl);

    if (token != null && token.isNotEmpty && role != null && role.isNotEmpty) {
      // Authenticate via notifier
      await ref.read(authProvider.notifier).handleDeepLinkAuth(
        token: token,
        role: role,
        userId: userId,
      );
      
      if (mounted) {
        final dashboardRoute = safeReturnUrl ?? AuthNotifier.getDashboardRouteForRole(role);
        context.go(dashboardRoute);
      }
    } else {
      if (mounted) {
        final encodedReturn = rawReturnUrl != null ? '&returnUrl=${Uri.encodeQueryComponent(rawReturnUrl)}' : '';
        context.go('${CommonRoutes.authError}?error=missing_params$encodedReturn');
      }
    }
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(
              tr('auth.provision_workspace'),
              style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
