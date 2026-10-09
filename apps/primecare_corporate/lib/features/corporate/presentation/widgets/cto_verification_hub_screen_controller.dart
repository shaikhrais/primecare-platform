// Governance - Category: controller | Purpose: Non-executable scaffold for CtoVerificationHubScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ctoVerificationHubScreenControllerProvider =
    NotifierProvider<
      CtoVerificationHubScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoVerificationHubScreenController();
    });

class CtoVerificationHubScreenController extends BaseScaffoldController {}
