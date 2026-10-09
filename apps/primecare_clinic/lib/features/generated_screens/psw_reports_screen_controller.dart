// Governance - Category: controller | Purpose: Non-executable scaffold for PswReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final pswReportsScreenControllerProvider =
    NotifierProvider<
      PswReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswReportsScreenController();
    });

class PswReportsScreenController extends BaseScaffoldController {}
