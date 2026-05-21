import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:web/web.dart' as web;

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
  runApp(
    ProviderScope(
      overrides: [
        platformApplicationProvider.overrideWithValue(AuthApplication()),
      ],
      child: const PrimeCareAuthApp(),
    ),
  );
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

final authRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authListenable,
    redirect: (context, state) {
      final isAtLogin = state.uri.path == '/login';
      final redirectUri = state.uri.queryParameters['redirect_uri'];

      // If authenticated and trying to log in (or just logged in)
      if (authState.isAuthenticated) {
        if (redirectUri != null && redirectUri.isNotEmpty) {
          // If the redirect URI is a native deep link (primecare://)
          if (redirectUri.startsWith('primecare://')) {
            // Append the token and role for the native app to consume
            final delimiter = redirectUri.contains('?') ? '&' : '?';
            final urlWithToken = '$redirectUri${delimiter}token=${authState.token ?? ''}&role=${Uri.encodeComponent(authState.role ?? '')}&userId=${authState.userId ?? ''}';
            
            // Redirect using location.href. The OS should intercept it.
            web.window.location.href = urlWithToken;
            return null;
          }

          // Web/standard redirect
          web.window.location.href = redirectUri;
          return null; // Stop flutter routing
        }
        // Fallback if no redirect URI was provided
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
        builder: (context, state) => Scaffold(
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: const SignInView(),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/success',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text(
              'Authentication Successful.\nYou may close this window or return to the application.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    ],
  );
});
