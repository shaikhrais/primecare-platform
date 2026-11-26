// Governance - Category: controller | Purpose: Non-executable scaffold for CtoAuditLogsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final ctoAuditLogsScreenControllerProvider =
    NotifierProvider<
      CtoAuditLogsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CtoAuditLogsScreenController();
    });

class CtoAuditLogsScreenController extends BaseScaffoldController {}
