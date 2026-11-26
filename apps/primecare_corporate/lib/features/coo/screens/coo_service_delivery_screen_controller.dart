// Governance - Category: controller | Purpose: Non-executable scaffold for CooServiceDeliveryScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cooServiceDeliveryScreenControllerProvider =
    NotifierProvider<
      CooServiceDeliveryScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CooServiceDeliveryScreenController();
    });

class CooServiceDeliveryScreenController extends BaseScaffoldController {}
