// Governance - Category: controller | Purpose: Non-executable scaffold for PswHelpSupportScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final pswHelpSupportScreenControllerProvider =
    NotifierProvider<
      PswHelpSupportScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswHelpSupportScreenController();
    });

class PswHelpSupportScreenController extends BaseScaffoldController {}
