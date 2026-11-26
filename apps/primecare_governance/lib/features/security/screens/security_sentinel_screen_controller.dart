// Governance - Category: controller | Purpose: Non-executable scaffold for SecuritySentinelScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final securitySentinelScreenControllerProvider =
    NotifierProvider<
      SecuritySentinelScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SecuritySentinelScreenController();
    });

class SecuritySentinelScreenController extends BaseScaffoldController {}
