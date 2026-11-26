// Governance - Category: controller | Purpose: Non-executable scaffold for PswCheckInScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final pswCheckInScreenControllerProvider =
    NotifierProvider<
      PswCheckInScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswCheckInScreenController();
    });

class PswCheckInScreenController extends BaseScaffoldController {}
