// Governance - Category: controller | Purpose: Non-executable scaffold for SecuritySentinelScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final securitySentinelScreenControllerProvider =
    NotifierProvider<
      SecuritySentinelScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SecuritySentinelScreenController();
    });

class SecuritySentinelScreenController extends BaseScaffoldController {}
