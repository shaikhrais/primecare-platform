// Governance - Category: controller | Purpose: Non-executable scaffold for LocalMarketingManagerLeadsScreenController
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/controllers.dart';

final localMarketingManagerLeadsScreenControllerProvider =
    NotifierProvider<
      LocalMarketingManagerLeadsScreenController,
      AsyncValue<Map<String, dynamic>>
    >(() {
      return LocalMarketingManagerLeadsScreenController();
    });

class LocalMarketingManagerLeadsScreenController
    extends BaseScaffoldController {}
