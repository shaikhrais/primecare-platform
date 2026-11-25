// Governance - Category: controller | Purpose: Provider for the active platform application. Applications (Corporate, Clinical, etc.) should override this in their ...
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/domain_governance.dart';

/// Provider for the active platform application.
/// Applications (Corporate, Clinical, etc.) should override this in their root ProviderScope.
final platformApplicationProvider = Provider<PlatformApplication>((ref) {
  throw UnimplementedError('platformApplicationProvider must be overridden in the application root.');
});
