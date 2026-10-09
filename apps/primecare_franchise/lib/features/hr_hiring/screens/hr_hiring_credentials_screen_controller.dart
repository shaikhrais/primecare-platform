// Governance - Category: controller | Purpose: Non-executable scaffold for HrHiringCredentialsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final hrHiringCredentialsScreenControllerProvider =
    NotifierProvider<
      HrHiringCredentialsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return HrHiringCredentialsScreenController();
    });

class HrHiringCredentialsScreenController extends BaseScaffoldController {}
