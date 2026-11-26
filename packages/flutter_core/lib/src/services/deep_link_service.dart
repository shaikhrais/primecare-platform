// Governance - Category: service | Purpose: Provider to manage the deep link listener lifecycle
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:protocol_registry/protocol_registry.dart';

// Provider to manage the deep link listener lifecycle
final deepLinkServiceProvider = Provider<DeepLinkService>((ref) {
  final service = DeepLinkService(ref);
  service.initialize();
  ref.onDispose(() => service.dispose());
  return service;
});

class DeepLinkService {
  final Ref _ref;
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _subscription;

  DeepLinkService(this._ref) {
    _appLinks = AppLinks();
  }

  void initialize() async {
    // Only strictly needed on native (Windows, Android, iOS) where web doesn't handle the deep link.
    if (kIsWeb) return;

    if (Platform.isWindows) {
      try {
        final registry = getRegistry();
        await registry.add(ProtocolScheme(
          scheme: 'primecare',
          appName: 'PrimeCare',
          appPath: Platform.resolvedExecutable,
        ));
      } catch (e) {
        debugPrint('Failed to register Windows protocol: $e');
      }
    }

    // Listen to incoming deep links while the app is running
    _subscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleIncomingUri(uri);
      }
    }, onError: (dynamic err) {
      debugPrint('Error listening to deep links: $err');
    });

    // Check if the app was opened with a deep link (cold start)
    _checkInitialLink();
  }

  Future<void> _checkInitialLink() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleIncomingUri(initialUri);
      }
    } catch (e) {
      debugPrint('Failed to get initial link: $e');
    }
  }

  void _handleIncomingUri(Uri uri) {
    debugPrint('Received Deep Link: $uri');
    
    // Example: primecare://auth/callback?token=xxx&role=xxx&userId=xxx
    if (uri.scheme == 'primecare' && uri.host == 'auth' && uri.path == '/callback') {
      final token = uri.queryParameters['token'];
      final role = uri.queryParameters['role'];
      final userId = uri.queryParameters['userId'];
      
      if (token != null && token.isNotEmpty) {
        _ref.read(authProvider.notifier).handleDeepLinkAuth(
          token: token,
          role: role ?? 'psw', // Default fallback
          userId: userId ?? '',
        );
      }
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
