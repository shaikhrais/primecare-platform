// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyMemberLovedOneScheduleScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final familyMemberLovedOneScheduleScreenControllerProvider =
    NotifierProvider<
      FamilyMemberLovedOneScheduleScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyMemberLovedOneScheduleScreenController();
    });

class FamilyMemberLovedOneScheduleScreenController
    extends BaseScaffoldController {}
