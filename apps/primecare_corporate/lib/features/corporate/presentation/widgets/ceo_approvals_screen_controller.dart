// Governance - Category: controller | Purpose: Non-executable scaffold for CeoApprovalsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ceoApprovalsScreenControllerProvider =
    NotifierProvider<
      CeoApprovalsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoApprovalsScreenController();
    });

class CeoApprovalsScreenController extends BaseScaffoldController {}
