// Governance - Category: controller | Purpose: Non-executable scaffold for CeoReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final ceoReportsScreenControllerProvider =
    NotifierProvider<
      CeoReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CeoReportsScreenController();
    });

class CeoReportsScreenController extends BaseScaffoldController {}
