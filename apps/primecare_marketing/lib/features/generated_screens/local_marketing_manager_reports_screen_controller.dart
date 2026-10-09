// Governance - Category: controller | Purpose: Non-executable scaffold for LocalMarketingManagerReportsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final localMarketingManagerReportsScreenControllerProvider =
    NotifierProvider<
      LocalMarketingManagerReportsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LocalMarketingManagerReportsScreenController();
    });

class LocalMarketingManagerReportsScreenController
    extends BaseScaffoldController {}
