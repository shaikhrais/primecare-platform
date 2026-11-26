// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmMeetingsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalBdmMeetingsScreenControllerProvider =
    NotifierProvider<
      RegionalBdmMeetingsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmMeetingsScreenController();
    });

class RegionalBdmMeetingsScreenController extends BaseScaffoldController {}
