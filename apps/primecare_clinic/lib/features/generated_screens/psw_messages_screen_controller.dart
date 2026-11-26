// Governance - Category: controller | Purpose: Non-executable scaffold for PswMessagesScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final pswMessagesScreenControllerProvider =
    NotifierProvider<
      PswMessagesScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return PswMessagesScreenController();
    });

class PswMessagesScreenController extends BaseScaffoldController {}
