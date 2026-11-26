// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyMemberLovedOneScheduleScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final familyMemberLovedOneScheduleScreenControllerProvider =
    NotifierProvider<
      FamilyMemberLovedOneScheduleScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyMemberLovedOneScheduleScreenController();
    });

class FamilyMemberLovedOneScheduleScreenController
    extends BaseScaffoldController {}
