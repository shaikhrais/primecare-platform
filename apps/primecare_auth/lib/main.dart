// Governance - Category: service | Purpose: Core implementation file for the Main platform logic.
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:web/web.dart' as web;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/semantics.dart';

class AuthTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_hq';

  @override
  String get name => 'PrimeCare';

  @override
  ThemeData get branding => ThemeData.light().copyWith(
        primaryColor: const Color(0xFF0F172A), // Slate 900
      );
}

class AuthApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_auth';

  @override
  String get name => 'PrimeCare Identity Portal';

  @override
  PlatformTenant get tenant => AuthTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [];
}

void main() {
  configureUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [
        platformApplicationProvider.overrideWithValue(AuthApplication()),
      ],
      child: const PrimeCareAuthApp(),
    ),
  );
  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }
}

class PrimeCareAuthApp extends ConsumerWidget {
  const PrimeCareAuthApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(authRouterProvider);
    return MaterialApp.router(
      title: 'PrimeCare Identity Portal',
      theme: ThemeData.light(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

// Memory-safe guard to ensure force_login is only evaluated once per page mount
bool _hasForcedLogout = false;

final authRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authListenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      if (!authState.isInitialized) {
        return null;
      }
      final isAtLogin = state.uri.path == '/login';
      final redirectUri = state.uri.queryParameters['redirect_uri'];

      final forceLogin = state.uri.queryParameters['force_login'] == 'true';
      if (forceLogin && !_hasForcedLogout) {
        _hasForcedLogout = true;
        if (authState.isAuthenticated) {
          Future.microtask(() {
            ref.read(authProvider.notifier).logout();
          });
        }
        if (kIsWeb) {
          try {
            final uri = Uri.parse(web.window.location.href);
            final params = Map<String, String>.from(uri.queryParameters)..remove('force_login');
            final newUri = uri.replace(queryParameters: params.isEmpty ? null : params);
            web.window.history.replaceState(null, '', newUri.toString());
          } catch (_) {}
        }
        return '/login${redirectUri != null ? '?redirect_uri=${Uri.encodeComponent(redirectUri)}' : ''}';
      }

      if (!forceLogin) {
        _hasForcedLogout = false;
      }

      // If authenticated and trying to log in (or just logged in)
      if (authState.isAuthenticated) {
        if (redirectUri != null && redirectUri.isNotEmpty) {
          // If already at the consent page, stay there
          if (state.uri.path == '/consent') {
            return null;
          }
          // Redirect to secure consent page instead of silent auto-redirect
          return '/consent?redirect_uri=${Uri.encodeComponent(redirectUri)}';
        }
        
        // If not redirecting, show success profile dashboard
        if (state.uri.path == '/success') {
          return null;
        }
        return '/success';
      }

      if (!authState.isAuthenticated && !isAtLogin) {
        return '/login${redirectUri != null ? '?redirect_uri=${Uri.encodeComponent(redirectUri)}' : ''}';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginViewWrapper(),
      ),
      GoRoute(
        path: '/success',
        builder: (context, state) => const SuccessProfileView(),
      ),
      GoRoute(
        path: '/consent',
        builder: (context, state) {
          final redirectUri = state.uri.queryParameters['redirect_uri'] ?? '';
          return ConsentView(redirectUri: redirectUri);
        },
      ),
    ],
  );
});

class LoginViewWrapper extends ConsumerWidget {
  const LoginViewWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isAuthenticated && !(previous?.isAuthenticated ?? false)) {
        final state = GoRouterState.of(context);
        final redirectUri = state.uri.queryParameters['redirect_uri'];
        if (redirectUri != null && redirectUri.isNotEmpty) {
          context.go('/consent?redirect_uri=${Uri.encodeComponent(redirectUri)}');
        } else {
          context.go('/success');
        }
      }
    });

    return const LoginView();
  }
}

class SuccessProfileView extends ConsumerWidget {
  const SuccessProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Slate 50
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  LucideIcons.shieldCheck,
                  size: 64,
                  color: Color(0xFF0F172A), // Slate 900
                ),
                const SizedBox(height: 16),
                Text(
                  'Identity Portal',
                  style: theme.typography.h1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your session is securely verified',
                  style: theme.typography.bodyMedium.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 32),

                PrimeCareCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Active Session',
                            style: theme.typography.labelBold.copyWith(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Logged In As',
                        style: theme.typography.labelMedium.copyWith(
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authState.userName ?? 'PrimeCare User',
                        style: theme.typography.h2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Assigned Platform Role',
                        style: theme.typography.labelMedium.copyWith(
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(theme.radiusSm),
                        ),
                        child: Text(
                          (authState.role ?? 'PSW').toUpperCase(),
                          style: theme.typography.bodySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Session Token:',
                            style: theme.typography.bodySmall.copyWith(
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          Text(
                            authState.token != null && authState.token!.length > 10
                                ? '${authState.token!.substring(0, 10)}...'
                                : (authState.token ?? 'demo'),
                            style: theme.typography.bodySmall.copyWith(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                const SystemIntegrityManifest(),
                const SizedBox(height: 32),

                PrimeButton.secondary(
                  label: 'Sign Out Account',
                  isFullWidth: true,
                  icon: LucideIcons.logOut,
                  onPressed: () async {
                    await ref.read(authProvider.notifier).logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConsentView extends ConsumerStatefulWidget {
  final String redirectUri;

  const ConsentView({super.key, required this.redirectUri});

  @override
  ConsumerState<ConsentView> createState() => _ConsentViewState();
}

class _ConsentViewState extends ConsumerState<ConsentView> {
  bool _isRedirecting = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = context.theme;
    
    String appHost = widget.redirectUri;
    try {
      final uri = Uri.parse(widget.redirectUri);
      appHost = uri.host.isNotEmpty ? uri.host : widget.redirectUri;
    } catch (_) {}

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Slate 50
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  LucideIcons.shieldAlert,
                  size: 64,
                  color: Color(0xFF0F172A), // Slate 900
                ),
                const SizedBox(height: 16),
                Text(
                  'Authorize Application',
                  style: theme.typography.h1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Security Consent Required',
                  style: theme.typography.bodyMedium.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 32),

                PrimeCareCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PERMISSION REQUEST',
                        style: theme.typography.labelBold.copyWith(
                          color: theme.colors.primary,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'The application at the following address wants to sign in using your PrimeCare Identity:',
                        style: theme.typography.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9), // Slate 100
                          borderRadius: BorderRadius.circular(theme.radiusSm),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          appHost,
                          style: theme.typography.bodyMedium.copyWith(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      Text(
                        'AUTHORIZING ACCOUNT',
                        style: theme.typography.labelBold.copyWith(
                          color: const Color(0xFF64748B),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFF0F172A),
                            radius: 20,
                            child: Text(
                              (authState.userName ?? 'U')[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authState.userName ?? 'PrimeCare User',
                                  style: theme.typography.bodyMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  (authState.role ?? 'PSW').toUpperCase(),
                                  style: theme.typography.bodySmall.copyWith(
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                PrimeButton.primary(
                  label: _isRedirecting ? 'Redirecting...' : 'Approve & Continue',
                  isFullWidth: true,
                  isLoading: _isRedirecting,
                  icon: LucideIcons.checkCircle,
                  onPressed: _isRedirecting
                      ? null
                      : () async {
                          setState(() {
                            _isRedirecting = true;
                          });

                          await Future<void>.delayed(
                            const Duration(milliseconds: 600),
                          );

                          final redirectUri = widget.redirectUri;
                          final delimiter = redirectUri.contains('?') ? '&' : '?';
                          final urlWithToken = '$redirectUri${delimiter}token=${authState.token ?? ''}&role=${Uri.encodeComponent(authState.role ?? '')}&userId=${authState.userId ?? ''}';
                          web.window.location.href = urlWithToken;
                        },
                ),
                const SizedBox(height: 12),
                PrimeButton.ghost(
                  label: 'Cancel & Sign Out',
                  isFullWidth: true,
                  icon: LucideIcons.xCircle,
                  onPressed: () async {
                    await ref.read(authProvider.notifier).logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
