// Governance - Category: controller | Purpose: Non-executable scaffold for CfoTaxAndRemittanceScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final cfoTaxAndRemittanceScreenControllerProvider =
    NotifierProvider<
      CfoTaxAndRemittanceScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return CfoTaxAndRemittanceScreenController();
    });

class CfoTaxAndRemittanceScreenController extends BaseScaffoldController {}
