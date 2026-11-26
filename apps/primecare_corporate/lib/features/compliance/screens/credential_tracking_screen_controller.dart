// Governance - Category: controller | Purpose: Non-executable scaffold for CredentialTrackingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final credentialTrackingScreenControllerProvider =
    NotifierProvider<
      CredentialTrackingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CredentialTrackingScreenController();
    });

class CredentialTrackingScreenController extends BaseScaffoldController {}
