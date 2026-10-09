// Governance - Category: controller | Purpose: Non-executable scaffold for SecurityHubScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final securityHubScreenControllerProvider =
    NotifierProvider<
      SecurityHubScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return SecurityHubScreenController();
    });

class SecurityHubScreenController extends BaseScaffoldController {}
