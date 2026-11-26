// Governance - Category: controller | Purpose: Non-executable scaffold for AdminRefundsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final adminRefundsScreenControllerProvider =
    NotifierProvider<
      AdminRefundsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminRefundsScreenController();
    });

class AdminRefundsScreenController extends BaseScaffoldController {}
