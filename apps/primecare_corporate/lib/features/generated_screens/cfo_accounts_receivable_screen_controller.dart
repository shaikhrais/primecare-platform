// Governance - Category: controller | Purpose: Non-executable scaffold for CfoAccountsReceivableScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cfoAccountsReceivableScreenControllerProvider =
    NotifierProvider<
      CfoAccountsReceivableScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoAccountsReceivableScreenController();
    });

class CfoAccountsReceivableScreenController extends BaseScaffoldController {}
