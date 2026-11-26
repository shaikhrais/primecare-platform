// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyMemberBillingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final familyMemberBillingScreenControllerProvider =
    NotifierProvider<
      FamilyMemberBillingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyMemberBillingScreenController();
    });

class FamilyMemberBillingScreenController extends BaseScaffoldController {}
