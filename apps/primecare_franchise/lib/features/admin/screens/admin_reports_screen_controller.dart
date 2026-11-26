// Governance - Category: controller | Purpose: Non-executable scaffold for AdminReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final adminReportsScreenControllerProvider =
    NotifierProvider<
      AdminReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminReportsScreenController();
    });

class AdminReportsScreenController extends BaseScaffoldController {}
