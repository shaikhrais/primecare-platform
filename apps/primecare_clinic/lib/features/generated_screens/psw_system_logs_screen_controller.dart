// Governance - Category: controller | Purpose: Non-executable scaffold for PswSystemLogsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final pswSystemLogsScreenControllerProvider =
    NotifierProvider<
      PswSystemLogsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswSystemLogsScreenController();
    });

class PswSystemLogsScreenController extends BaseScaffoldController {}
