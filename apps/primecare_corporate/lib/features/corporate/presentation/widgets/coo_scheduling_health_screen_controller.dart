// Governance - Category: controller | Purpose: Non-executable scaffold for CooSchedulingHealthScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final cooSchedulingHealthScreenControllerProvider =
    NotifierProvider<
      CooSchedulingHealthScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooSchedulingHealthScreenController();
    });

class CooSchedulingHealthScreenController extends BaseScaffoldController {}
