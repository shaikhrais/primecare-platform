// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyBillingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final familyBillingScreenControllerProvider =
    NotifierProvider<
      FamilyBillingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyBillingScreenController();
    });

class FamilyBillingScreenController extends BaseScaffoldController {}
