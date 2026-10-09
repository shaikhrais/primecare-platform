// Governance - Category: controller | Purpose: Non-executable scaffold for AuditLogScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final auditLogScreenControllerProvider =
    NotifierProvider<
      AuditLogScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AuditLogScreenController();
    });

class AuditLogScreenController extends BaseScaffoldController {}
