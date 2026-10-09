// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyLovedOneScheduleScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final familyLovedOneScheduleScreenControllerProvider =
    NotifierProvider<
      FamilyLovedOneScheduleScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyLovedOneScheduleScreenController();
    });

class FamilyLovedOneScheduleScreenController extends BaseScaffoldController {}
