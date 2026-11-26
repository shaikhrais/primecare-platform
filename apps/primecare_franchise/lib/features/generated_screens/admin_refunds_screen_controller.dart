// Governance - Category: controller | Purpose: Non-executable scaffold for AdminRefundsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final adminRefundsScreenControllerProvider =
    NotifierProvider<
      AdminRefundsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminRefundsScreenController();
    });

class AdminRefundsScreenController extends BaseScaffoldController {}
