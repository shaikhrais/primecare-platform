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
// Governance - Category: app_entry | Purpose: System-level main entrypoint
// PRIME:SCREEN=consent
// PRIME:SCREEN=success_profile
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
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



// This app previews the same auth screens embedded by the product apps.
final authRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: CommonRoutes.login,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final session = ref.read(authProvider);
      if (!session.isInitialized) return null;
      final path = state.uri.path;
      if (session.isAuthenticated && (path == '/' || path == CommonRoutes.login)) {
        return '/success';
      }
      if (!session.isAuthenticated && !SharedAuthRoutes.publicPaths.contains(path)) {
        return CommonRoutes.login;
      }
      return null;
    },
    routes: [
      ...SharedAuthRoutes.routes(),
      ...SharedAuthRoutes.protectedRoutes(),
    ],
  );
});
