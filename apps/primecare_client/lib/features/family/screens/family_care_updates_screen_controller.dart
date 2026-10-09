// Governance - Category: controller | Purpose: Non-executable scaffold for FamilyCareUpdatesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final familyCareUpdatesScreenControllerProvider =
    NotifierProvider<
      FamilyCareUpdatesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return FamilyCareUpdatesScreenController();
    });

class FamilyCareUpdatesScreenController extends BaseScaffoldController {}
