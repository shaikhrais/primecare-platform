// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringCredentialsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final hrHiringCredentialsScreenControllerProvider =
    NotifierProvider<
      HrHiringCredentialsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringCredentialsScreenController();
    });

class HrHiringCredentialsScreenController extends BaseScaffoldController {}
