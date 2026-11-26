// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmMeetingsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final regionalBdmMeetingsScreenControllerProvider =
    NotifierProvider<
      RegionalBdmMeetingsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmMeetingsScreenController();
    });

class RegionalBdmMeetingsScreenController extends BaseScaffoldController {}
