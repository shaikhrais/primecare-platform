// Governance - Category: controller | Purpose: Non-executable scaffold for LocalMarketingManagerEventsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final localMarketingManagerEventsScreenControllerProvider =
    NotifierProvider<
      LocalMarketingManagerEventsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LocalMarketingManagerEventsScreenController();
    });

class LocalMarketingManagerEventsScreenController
    extends BaseScaffoldController {}
