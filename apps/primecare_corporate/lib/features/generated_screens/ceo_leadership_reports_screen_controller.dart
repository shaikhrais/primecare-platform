// Governance - Category: controller | Purpose: Non-executable scaffold for CeoLeadershipReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final ceoLeadershipReportsScreenControllerProvider =
    NotifierProvider<
      CeoLeadershipReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoLeadershipReportsScreenController();
    });

class CeoLeadershipReportsScreenController extends BaseScaffoldController {}
