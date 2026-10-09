// Governance - Category: controller | Purpose: Non-executable scaffold for CfoInvoicesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cfoInvoicesScreenControllerProvider =
    NotifierProvider<
      CfoInvoicesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoInvoicesScreenController();
    });

class CfoInvoicesScreenController extends BaseScaffoldController {}
