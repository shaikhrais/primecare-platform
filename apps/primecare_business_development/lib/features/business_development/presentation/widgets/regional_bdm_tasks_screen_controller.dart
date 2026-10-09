// Governance - Category: controller | Purpose: Non-executable scaffold for RegionalBdmTasksScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final regionalBdmTasksScreenControllerProvider =
    NotifierProvider<
      RegionalBdmTasksScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RegionalBdmTasksScreenController();
    });

class RegionalBdmTasksScreenController extends BaseScaffoldController {}
