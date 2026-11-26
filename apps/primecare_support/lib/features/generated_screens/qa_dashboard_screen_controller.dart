// Governance - Category: controller | Purpose: Non-executable scaffold for QaDashboardScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final qaDashboardScreenControllerProvider =
    NotifierProvider<
      QaDashboardScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return QaDashboardScreenController();
    });

class QaDashboardScreenController extends BaseScaffoldController {}
