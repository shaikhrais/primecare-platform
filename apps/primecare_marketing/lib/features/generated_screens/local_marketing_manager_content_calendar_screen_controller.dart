// Governance - Category: controller | Purpose: Non-executable scaffold for LocalMarketingManagerContentCalendarScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_runtime/controllers.dart';

final localMarketingManagerContentCalendarScreenControllerProvider =
    NotifierProvider<
      LocalMarketingManagerContentCalendarScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LocalMarketingManagerContentCalendarScreenController();
    });

class LocalMarketingManagerContentCalendarScreenController
    extends BaseScaffoldController {}
