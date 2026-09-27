import 'package:flutter/material.dart';
import 'package:flutter_core/registry/widgets/responsive_screen_wrapper.dart';
import 'governance/screen_health_panel.dart';

/// A service that bootstraps the platform governance engine and ensures
/// all registries are synchronized and audited at startup.
class GovernanceBootstrapper {
  static Future<void> bootstrap() async {
    debugPrint('GOVERNANCE_BOOTSTRAP: Initializing platform audit engine...');
    
    // Register the global screen self-diagnosis overlay
    ResponsiveScreenWrapper.overlayBuilder = (context, routePath, child) {
      return ScreenHealthOverlayWrapper(routePath: routePath, child: child);
    };
  }
}
