// Governance - Category: controller | Purpose: Non-executable scaffold for PswHelpSupportScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final pswHelpSupportScreenControllerProvider =
    NotifierProvider<
      PswHelpSupportScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswHelpSupportScreenController();
    });

class PswHelpSupportScreenController extends BaseScaffoldController {}
