// Governance - Category: controller | Purpose: Non-executable scaffold for CooSchedulingHealthScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cooSchedulingHealthScreenControllerProvider =
    NotifierProvider<
      CooSchedulingHealthScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooSchedulingHealthScreenController();
    });

class CooSchedulingHealthScreenController extends BaseScaffoldController {}
