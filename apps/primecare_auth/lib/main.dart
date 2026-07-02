/* 
PRIME:SCREEN=consent
PRIME:DESIGN=DESIGN_STARTED
PRIME:HTML=HTML_LAYOUT_DONE
PRIME:COMP=COMP_MISSING
PRIME:LOGIC=LOGIC_NONE
PRIME:API=API_NONE
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=20
PRIME:BLOCKER=Placeholder detected: return null in build
PRIME:NEXT_ACTION=Remediate placeholder elements with real visual widgets
*/
// Governance - Category: service | Purpose: Core implementation file for the Main platform logic.
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/theme_config_generated.dart';
import 'package:web/web.dart' as web;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/semantics.dart';

class AuthTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_hq';

  @override
  String get name => 'PrimeCare';

  PrimeThemeData get primeThemeData => PrimeThemeData(
        colors: PrimeColors.fromPalette(ThemeConfig.getAppPalette('auth')),
      );

  @override
  ThemeData get branding => primeThemeData.toThemeData();
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

  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }

  PrimeCareAppRunner.run(
    appWidget: const PrimeCareAuthApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(AuthApplication()),
    ],
  );
}

class PrimeCareAuthApp extends ConsumerWidget {
  const PrimeCareAuthApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(authRouterProvider);
    final tenant = AuthTenant();
    final primeTheme = tenant.primeThemeData;

    return AppShellBoundary(
      child: PrimeTheme(
        data: primeTheme,
        child: MaterialApp.router(
          title: 'PrimeCare Identity Portal',
          theme: primeTheme.toThemeData(),
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        ),
      ),
    );
  }
}

// Memory-safe guard to ensure force_login is only evaluated once per page mount
String getPortalUrlForRole(String role) {
  final r = role.toLowerCase().replaceAll(' ', '_').replaceAll('/', '_');
  
  if (r.contains('ceo') || r.contains('cfo') || r.contains('ciso') || 
      r.contains('coo') || r.contains('cto') || r.contains('legal') || 
      r.contains('shareholder') || r.contains('compliance') || 
      r.contains('training_director') || r.contains('finance_director') || 
      r.contains('volunteer_coordinator') || r.contains('bus_dev') || 
      r.contains('marketing') || r.contains('cx_director') || r.contains('hr_director')) {
    return 'https://primecare-corporate.pages.dev';
  }
  
  if (r.contains('regional_manager') || r.contains('franchise_sales') || 
      r.contains('partnership') || r.contains('territory_expansion') || 
      r.contains('general_manager') || r.contains('gm') || r.contains('regional_bdm')) {
    return 'https://primecare-business-development.pages.dev';
  }
  
  if (r.contains('owner') || r.contains('ops_manager') || r.contains('scheduler') || 
      r.contains('coordinator') || r.contains('billing_admin') || r.contains('hr_hiring') || r.contains('hr_manager')) {
    return 'https://primecare-franchise.pages.dev';
  }
  
  if (r.contains('customer_support') || r.contains('premium_concierge') || r.contains('vip_manager') || r.contains('qa_specialist')) {
    return 'https://primecare-support.pages.dev';
  }
  
  if (r.contains('local_marketing') || r.contains('community_outreach')) {
    return 'https://primecare-marketing.pages.dev';
  }
  
  if (r.contains('clinical_director') || r == 'psw' || r == 'chiropractor' || 
      r == 'physio' || r == 'physiotherapist' || r == 'rmt' || 
      r == 'social_worker' || r == 'therapist' || r == 'caregiver' || 
      r == 'rn' || r == 'rpn' || r == 'lpn' || r == 'np' || r == 'physician' || r == 'cns' || r == 'pediatric' || r == 'hsw') {
    return 'https://primecare-clinic.pages.dev';
  }
  
  if (r == 'client' || r.contains('family') || r == 'patient' || r == 'portal') {
    return 'https://primecare-client.pages.dev';
  }
  
  if (r.contains('system_verification') || r.contains('infrastructure') || 
      r.contains('dynamic') || r.contains('training') || r == 'admin' || r == 'employee' || r == 'volunteer' || r == 'governance') {
    return 'https://primecare-governance.pages.dev';
  }
  
  return 'https://primecare-auth.pages.dev';
}

final loginSuccessRedirectProvider = StateProvider<bool>((ref) => false);

// Memory-safe guard to ensure force_login is only evaluated once per page mount
bool _hasForcedLogout = false;

final authRouterProvider = Provider<GoRouter>((ref) {
  // Clean Rebuild: Recreates GoRouter delegate to force refreshing current active route with new locale context
  ref.watch(languageProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authListenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      if (!authState.isInitialized) {
        return null;
      }
      final isAtLogin = state.uri.path == '/login';
      final isAtLanguage = state.uri.path == '/language';
      final redirectUri = state.uri.queryParameters['redirect_uri'];

      // Reset the flag when we leave the login page
      if (!isAtLogin) {
        Future.microtask(() {
          ref.read(loginSuccessRedirectProvider.notifier).state = false;
        });
      }

      // Redirection: Check if a language has ever been persistently selected
      final prefs = ref.read(sharedPreferencesProvider);
      final hasSelectedLanguage = prefs?.getBool('auth_language_selected') ?? false;

      if (!hasSelectedLanguage && !isAtLanguage) {
        return '/language${redirectUri != null ? '?redirect_uri=${Uri.encodeComponent(redirectUri)}' : ''}';
      }

      final justLoggedIn = ref.read(loginSuccessRedirectProvider);

      // Force logout if the user directly accesses the login route to ensure credentials entry is shown
      if (isAtLogin && authState.isAuthenticated && !justLoggedIn) {
        Future.microtask(() {
          ref.read(authProvider.notifier).logout();
        });
        return null;
      }

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
          final delimiter = redirectUri.contains('?') ? '&' : '?';
          final urlWithToken = '$redirectUri${delimiter}token=${authState.token ?? ''}&role=${Uri.encodeComponent(authState.role ?? '')}&userId=${authState.userId ?? ''}';
          if (kIsWeb) {
            Future.microtask(() {
              web.window.location.href = urlWithToken;
            });
          }
          return null;
        }

        // If not redirecting, show App Hub success route
        if (state.uri.path == '/success') {
          return null;
        }
        return '/success';
      }

      if (!authState.isAuthenticated && !isAtLogin && !isAtLanguage) {
        return '/login${redirectUri != null ? '?redirect_uri=${Uri.encodeComponent(redirectUri)}' : ''}';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/language',
        builder: (context, state) => const LanguageSelectionView(),
      ),
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
        ref.read(loginSuccessRedirectProvider.notifier).state = true;
        final state = GoRouterState.of(context);
        final redirectUri = state.uri.queryParameters['redirect_uri'];
        if (redirectUri != null && redirectUri.isNotEmpty) {
          final delimiter = redirectUri.contains('?') ? '&' : '?';
          final urlWithToken = '$redirectUri${delimiter}token=${next.token ?? ''}&role=${Uri.encodeComponent(next.role ?? '')}&userId=${next.userId ?? ''}';
          if (kIsWeb) {
            web.window.location.href = urlWithToken;
          }
        } else {
          context.go('/success');
        }
      }
    });

    return const LoginScreen();
  }
}

class SuccessProfileView extends GovernedScreen {
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

  const SuccessProfileView({super.key});

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

  bool _hasAccessToPortal(String role, String portalUrl) {
    final userPortal = getPortalUrlForRole(role);
    final r = role.toLowerCase();
    
    // Super admin / governance roles get access to everything for cross-system debugging
    if (r == 'admin' || r == 'governance' || r == 'system_verification' || r == 'ciso') {
      return true;
    }
    
    return userPortal == portalUrl;
  }

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = context.theme;

    final portalApps = [
      {
        'name': 'Corporate Headquarters',
        'url': 'https://primecare-corporate.pages.dev',
        'icon': LucideIcons.building,
        'description': 'Executive leadership, financial planning, HR, legal, compliance, and training management.',
        'color': const Color(0xFF60A5FA), // Blue
      },
      {
        'name': 'Business Development',
        'url': 'https://primecare-business-development.pages.dev',
        'icon': LucideIcons.trendingUp,
        'description': 'Partnerships, regional growth, franchise sales, market research, and expansion planning.',
        'color': const Color(0xFF818CF8), // Indigo
      },
      {
        'name': 'Franchise Operations',
        'url': 'https://primecare-franchise.pages.dev',
        'icon': LucideIcons.briefcase,
        'description': 'Local franchise ownership, office operations, local hiring, and client billing.',
        'color': const Color(0xFF22D3EE), // Cyan
      },
      {
        'name': 'Customer Support',
        'url': 'https://primecare-support.pages.dev',
        'icon': LucideIcons.phone,
        'description': 'VIP concierge care coordination, premium client support, and ticket management.',
        'color': const Color(0xFFFBBF24), // Amber
      },
      {
        'name': 'Marketing & Outreach',
        'url': 'https://primecare-marketing.pages.dev',
        'icon': LucideIcons.megaphone,
        'description': 'Local marketing campaigns, community events, partnerships, and brand assets.',
        'color': const Color(0xFFC084FC), // Purple
      },
      {
        'name': 'Clinical Intelligence',
        'url': 'https://primecare-clinic.pages.dev',
        'icon': LucideIcons.stethoscope,
        'description': 'Clinical director oversight, caregiver schedules, client vitals, and treatment plans.',
        'color': const Color(0xFF34D399), // Emerald/Green
      },
      {
        'name': 'Client Care Portal',
        'url': 'https://primecare-client.pages.dev',
        'icon': LucideIcons.heart,
        'description': 'Client appointments, loved one schedules, care team updates, and family billing.',
        'color': const Color(0xFFF472B6), // Pink/Rose
      },
      {
        'name': 'Platform Governance',
        'url': 'https://primecare-governance.pages.dev',
        'icon': LucideIcons.shieldCheck,
        'description': 'System integrity verification, infrastructure auditing, and dynamic blueprints.',
        'color': const Color(0xFF2DD4BF), // Teal
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Slate 900
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: const Icon(
                            LucideIcons.shieldCheck,
                            color: Colors.greenAccent,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PRIMECARE HQ',
                              style: theme.typography.labelMedium.copyWith(
                                color: Colors.white.withValues(alpha: 0.5),
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Application Hub',
                              style: theme.typography.h2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    // Profile + Logout Section
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.white.withValues(alpha: 0.1),
                                child: Text(
                                  (authState.userName ?? 'U')[0].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                authState.userName ?? 'auth_success_default_user'.tr(),
                                style: theme.typography.bodyMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.3)),
                                ),
                                child: Text(
                                  (authState.role ?? 'Guest').toUpperCase(),
                                  style: theme.typography.labelSmall.copyWith(
                                    color: Colors.greenAccent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          tooltip: 'auth_success_sign_out'.tr(),
                          icon: const Icon(LucideIcons.logOut, color: Colors.redAccent),
                          onPressed: () async {
                            await ref.read(authProvider.notifier).logout();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Welcome Message & Subtitle
                Text(
                  'Welcome to PrimeCare, ${authState.userName ?? "User"}.',
                  style: theme.typography.h1.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Launch your authorized workspace portals. Locked apps require role privilege upgrades.',
                  style: theme.typography.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                
                const SizedBox(height: 32),

                // Responsive Grid of App Cards
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 1.35,
                  ),
                  itemCount: portalApps.length,
                  itemBuilder: (context, index) {
                    final app = portalApps[index];
                    final name = app['name'] as String;
                    final url = app['url'] as String;
                    final icon = app['icon'] as IconData;
                    final description = app['description'] as String;
                    final accentColor = app['color'] as Color;
                    
                    final isAuthorized = _hasAccessToPortal(authState.role ?? 'Guest', url);

                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isAuthorized ? 1.0 : 0.45,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isAuthorized 
                              ? Colors.white.withValues(alpha: 0.03)
                              : Colors.white.withValues(alpha: 0.01),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isAuthorized 
                                ? accentColor.withValues(alpha: 0.25)
                                : Colors.white.withValues(alpha: 0.05),
                            width: 1.5,
                          ),
                          boxShadow: isAuthorized ? [
                            BoxShadow(
                              color: accentColor.withValues(alpha: 0.05),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            )
                          ] : null,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: isAuthorized ? () {
                              final dashboardRoute = AuthNotifier.getDashboardRouteForRole(authState.role ?? '');
                              final delimiter = url.contains('?') ? '&' : '?';
                              final redirectUrl = '$url/auth/callback${delimiter}route=${Uri.encodeComponent(dashboardRoute)}&token=${authState.token ?? ''}&role=${Uri.encodeComponent(authState.role ?? '')}&userId=${authState.userId ?? ''}';
                              if (kIsWeb) {
                                web.window.location.href = redirectUrl;
                              }
                            } : null,
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: accentColor.withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: accentColor.withValues(alpha: 0.2),
                                          ),
                                        ),
                                        child: Icon(
                                          icon,
                                          color: accentColor,
                                          size: 24,
                                        ),
                                      ),
                                      if (!isAuthorized)
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(alpha: 0.05),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            LucideIcons.lock,
                                            color: Colors.white54,
                                            size: 14,
                                          ),
                                        )
                                      else
                                        const Icon(
                                          LucideIcons.arrowRight,
                                          color: Colors.white54,
                                          size: 18,
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    name,
                                    style: theme.typography.h3.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: Text(
                                      description,
                                      style: theme.typography.bodyMedium.copyWith(
                                        color: Colors.white.withValues(alpha: 0.5),
                                        fontSize: 12,
                                        height: 1.4,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 48),
                const SystemIntegrityManifest(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConsentView extends GovernedScreen {
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

  const ConsentView({super.key, required this.redirectUri});

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
    return _ConsentViewBody(redirectUri: redirectUri);
  }
}

class _ConsentViewBody extends ConsumerStatefulWidget {
  final String redirectUri;

  const _ConsentViewBody({required this.redirectUri});

  @override
  ConsumerState<_ConsentViewBody> createState() => _ConsentViewBodyState();
}

class _ConsentViewBodyState extends ConsumerState<_ConsentViewBody> {
  @override
  void initState() {
    super.initState();
    _startAutoRedirect();
  }

  void _startAutoRedirect() {
    Future.microtask(() async {
      // Small delay to make the transition feel natural and visual feedback clean
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
    final theme = context.theme;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Premium Dark Slate
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Premium Glowing Shield Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  LucideIcons.shieldCheck,
                  size: 56,
                  color: Colors.greenAccent, // Secure Green Accent
                ),
              ),
              const SizedBox(height: 32),
              
              // Identity Gateway Branding
              Text(
                'PRIMECARE IDENTITY'.tr(),
                style: theme.typography.labelMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.5),
                  letterSpacing: 4.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'auth_consent_redirecting'.tr(),
                style: theme.typography.h2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Establishing secure session with the request application gateway...',
                style: theme.typography.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Smooth Circular Loader
              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
