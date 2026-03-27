import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_mobile/l10n/app_localizations.dart';

// Core Imports
import 'package:primecare_ui/primecare_ui.dart';
import 'core/theme_provider.dart';
import 'core/locale_provider.dart';
import 'core/network/offline_sync_manager.dart';

// Layout & Dynamic Routing Modules
import 'core/layouts/master_layout.dart';
import 'core/routing/dynamic_route_engine.dart';

import 'core/auth/auth_provider.dart';
import 'package:primecare_mobile/features/master/auth/login_screen.dart';
import 'package:primecare_mobile/features/master/auth/forgot_password_screen.dart';
import 'core/routing/screen_registry.dart';

// Global Pointer for Database Routes (Phase 24)
List<GoRoute> globalDatabaseRoutes = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OfflineSyncManager().initializeSyncListener();
  
  // Natively intercept launch to fetch the UI topology from the Cloudflare API
  globalDatabaseRoutes = await DynamicRouteEngine.fetchDatabaseRoutes();
  
  final prefs = await SharedPreferences.getInstance();
  final String savedRole = prefs.getString('user_role') ?? 'psw';
  
  runApp(ProviderScope(
    overrides: [
      authProvider.overrideWith(() => AuthNotifier(savedRole)),
    ],
    child: const PrimeCareApp(),
  ));
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    errorBuilder: (context, state) {
      return Scaffold(
        body: MasterLayout(
          currentPath: state.uri.toString(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.warning_amber_rounded, size: 80, color: Colors.orangeAccent),
                SizedBox(height: 24),
                Text('404 - Content Not Found', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo)),
                SizedBox(height: 8),
                Text('The requested page does not exist in the role matrix.', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          ),
        ),
      );
    },
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final hasToken = prefs.containsKey('auth_token');
      final isLoggingIn = state.uri.toString() == '/login';
      final isRoot = state.uri.toString() == '/';

      if (!hasToken && !isLoggingIn) return '/login';

      if (hasToken && (isLoggingIn || isRoot)) {
        final role = prefs.getString('user_role') ?? 'psw';
        switch (role) {
          case 'rn': return '/rn/home';
          case 'coordinator': return '/coordinator/home';
          case 'manager': return '/manager/home';
          case 'admin': return '/admin/home';
          case 'client': return '/client/home';
          case 'gm': return '/gm/home';
          case 'mt': return '/mt/home';
          case 'scrum': return '/scrum_master/home';
          case 'superuser': return '/superuser/home';
          default: return '/psw/home';
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => ForgotPasswordScreen(),
      ),

      // Immersive Communication Suites (Bypass Master Layout)
      GoRoute(
        path: '/:role/chat/:threadId',
        builder: (context, state) => ScreenRegistry.resolveScreen('universal_chat', state.pathParameters)
      ),
      GoRoute(
        path: '/:role/telehealth',
        builder: (context, state) => ScreenRegistry.resolveScreen('universal_telehealth', {
          'role': state.pathParameters['role'] ?? 'universal',
          'sessionType': state.uri.queryParameters['sessionType'] ?? 'audio',
          'peerId': state.uri.queryParameters['peerId'] ?? ''
        })
      ),

      ShellRoute(
        builder: (context, state, child) {
          return MasterLayout(
            currentPath: state.uri.toString(),
            child: child,
          );
        },
        routes: [
          // The static layout arrays have been entirely decoupled!
          ...globalDatabaseRoutes,
        ],
      ),
    ],
  );
});

class PrimeCareApp extends ConsumerWidget {
  const PrimeCareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.primecareMobile,
      theme: AppTheme.lightTheme,
      themeMode: ref.watch(themeProvider),
      routerConfig: appRouter,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
