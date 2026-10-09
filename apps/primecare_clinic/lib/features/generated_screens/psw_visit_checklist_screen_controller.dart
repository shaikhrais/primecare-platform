// Governance - Category: controller | Purpose: Non-executable scaffold for PswVisitChecklistScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final pswVisitChecklistScreenControllerProvider =
    NotifierProvider<
      PswVisitChecklistScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswVisitChecklistScreenController();
    });

class PswVisitChecklistScreenController extends BaseScaffoldController {}
