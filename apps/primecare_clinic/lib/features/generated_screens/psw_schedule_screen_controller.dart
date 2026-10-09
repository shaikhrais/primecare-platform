// Governance - Category: controller | Purpose: Non-executable scaffold for PswScheduleScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final pswScheduleScreenControllerProvider =
    NotifierProvider<
      PswScheduleScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswScheduleScreenController();
    });

class PswScheduleScreenController extends BaseScaffoldController {}
