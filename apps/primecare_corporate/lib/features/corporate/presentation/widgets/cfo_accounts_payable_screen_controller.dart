// Governance - Category: controller | Purpose: Non-executable scaffold for CfoAccountsPayableScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cfoAccountsPayableScreenControllerProvider =
    NotifierProvider<
      CfoAccountsPayableScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoAccountsPayableScreenController();
    });

class CfoAccountsPayableScreenController extends BaseScaffoldController {}
