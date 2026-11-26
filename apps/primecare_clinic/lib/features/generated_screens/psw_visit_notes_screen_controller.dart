// Governance - Category: controller | Purpose: Non-executable scaffold for PswVisitNotesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final pswVisitNotesScreenControllerProvider =
    NotifierProvider<
      PswVisitNotesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswVisitNotesScreenController();
    });

class PswVisitNotesScreenController extends BaseScaffoldController {}
