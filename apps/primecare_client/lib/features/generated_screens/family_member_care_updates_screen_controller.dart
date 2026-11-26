// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyMemberCareUpdatesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final familyMemberCareUpdatesScreenControllerProvider =
    NotifierProvider<
      FamilyMemberCareUpdatesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyMemberCareUpdatesScreenController();
    });

class FamilyMemberCareUpdatesScreenController extends BaseScaffoldController {}
