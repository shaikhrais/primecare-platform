// Governance - Category: middleware | Purpose: Handle SSO authorization callback logic on Web.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../auth_service.dart';
import 'groups/common_routes.dart';

class AuthCallbackView extends ConsumerStatefulWidget {
  final Map<String, String> queryParameters;

  const AuthCallbackView({super.key, required this.queryParameters});

  @override
  ConsumerState<AuthCallbackView> createState() => _AuthCallbackViewState();
}

class _AuthCallbackViewState extends ConsumerState<AuthCallbackView> {
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

    if (token != null && token.isNotEmpty && role != null && role.isNotEmpty) {
      // Authenticate via notifier
      await ref.read(authProvider.notifier).handleDeepLinkAuth(
        token: token,
        role: role,
        userId: userId,
      );
      
      // Redirect to the dashboard route or root of the app
      if (mounted) {
        final dashboardRoute = AuthNotifier.getDashboardRouteForRole(role);
        context.go(dashboardRoute);
      }
    } else {
      // Fallback if missing params
      if (mounted) {
        context.go(CommonRoutes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
