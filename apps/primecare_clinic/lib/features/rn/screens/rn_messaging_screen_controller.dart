// Governance - Category: controller | Purpose: Non-executable scaffold for RnMessagingScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final rnMessagingScreenControllerProvider =
    NotifierProvider<
      RnMessagingScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return RnMessagingScreenController();
    });

class RnMessagingScreenController extends BaseScaffoldController {}
