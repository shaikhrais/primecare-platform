// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyMemberCareUpdatesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final familyMemberCareUpdatesScreenControllerProvider =
    NotifierProvider<
      FamilyMemberCareUpdatesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyMemberCareUpdatesScreenController();
    });

class FamilyMemberCareUpdatesScreenController extends BaseScaffoldController {}
