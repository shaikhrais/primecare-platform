import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core Imports
import 'core/network/offline_sync_manager.dart';
import 'core/routing/dynamic_route_engine.dart';
import 'core/auth/auth_provider.dart';

// App Modules
import 'app.dart';
import 'core/routing/app_router.dart';

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
