// Governance - Category: controller | Purpose: Non-executable scaffold for AdminOutstandingBalancesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final adminOutstandingBalancesScreenControllerProvider =
    NotifierProvider<
      AdminOutstandingBalancesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return AdminOutstandingBalancesScreenController();
    });

class AdminOutstandingBalancesScreenController extends BaseScaffoldController {}
