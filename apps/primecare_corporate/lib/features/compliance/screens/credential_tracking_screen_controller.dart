// Governance - Category: controller | Purpose: Non-executable scaffold for CredentialTrackingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final credentialTrackingScreenControllerProvider =
    NotifierProvider<
      CredentialTrackingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CredentialTrackingScreenController();
    });

class CredentialTrackingScreenController extends BaseScaffoldController {}
