// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyBillingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final familyBillingScreenControllerProvider =
    NotifierProvider<
      FamilyBillingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyBillingScreenController();
    });

class FamilyBillingScreenController extends BaseScaffoldController {}
