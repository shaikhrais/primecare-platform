// Governance - Category: controller | Purpose: Non-executable scaffold for VerificationCenterScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final verificationCenterScreenControllerProvider =
    NotifierProvider<
      VerificationCenterScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return VerificationCenterScreenController();
    });

class VerificationCenterScreenController extends BaseScaffoldController {}
